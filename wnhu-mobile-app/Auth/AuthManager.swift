//
//  AuthManager.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 1/12/26.
//

import MSAL
import UIKit

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
    /*  Write sign in function */
    /* connect button with sign in authmanager*/
}
