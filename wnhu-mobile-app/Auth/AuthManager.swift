//
//  AuthManager.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 1/12/26.
//

import MSAL
import UIKit

/* Functions for signing in and out below */
class AuthManager {
    static let shared = AuthManager()
    
    private var applicationContext: MSALPublicClientApplication?
    
    init() {
        do {
            try initMSAL()
        } catch {
            print("MSAL init failed: \(error)")
        }
    }
    
    private func initMSAL() throws {
        let authorityURL = URL(string: Configuration.kAuthority)!
        let authority = try MSALAuthority(url: authorityURL)
        
        let config = MSALPublicClientApplicationConfig(
            clientId: Configuration.kClientID,
            redirectUri: Configuration.kRedirectUri,
            authority: authority
        )
        
        self.applicationContext = try MSALPublicClientApplication(configuration: config)
    }
}
    // Sign in function ran on the login page
    extension AuthManager {
        func signIn(completion: @escaping (Result<MSALResult, Error>) -> Void) {
            guard let applicationContext = self.applicationContext else {
                completion(.failure(NSError(domain: "MSAL", code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "MSAL not initialized"])))
                return
            }

            // Correct presentation anchor for iOS 15+
            let presenter = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }?
                .rootViewController

            guard let rootVC = presenter else {
                completion(.failure(NSError(domain: "MSAL", code: -3,
                    userInfo: [NSLocalizedDescriptionKey: "No rootViewController found"])))
                return
            }

            let webParams = MSALWebviewParameters(authPresentationViewController: rootVC)

            let parameters = MSALInteractiveTokenParameters(
                scopes: Configuration.kScopes,
                webviewParameters: webParams
            )

            applicationContext.acquireToken(with: parameters) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let result = result else {
                    completion(.failure(NSError(domain: "MSAL", code: -2,
                        userInfo: [NSLocalizedDescriptionKey: "No result returned"])))
                    return
                }
                completion(.success(result))
            }
        }

    }


 
