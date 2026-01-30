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
    
    // Sign in function ran on the login page
    func signIn(completion: @escaping (Result<MSALResult, Error>) -> Void) {
        guard let rootVC = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?
            .rootViewController else {
            print("No root view controller found")
            return
        }
        
        let webParams = MSALWebviewParameters(authPresentationViewController: rootVC)
        let params = MSALInteractiveTokenParameters(
            scopes: Configuration.kScopes,
            webviewParameters: webParams
        )
        
        applicationContext?.acquireToken(with: params) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let result = result {
                completion(.success(result))
            }
        }
    }

    // Need to add sign out
}
