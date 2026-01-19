//
//  AuthViewModel.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 1/14/26.
//

import SwiftUI
import MSAL

class AuthViewModel: ObservableObject {
    @Published var isSignedIn = false
    
    func signIn(appVariables: AppVariables, userData: UserData) {
        AuthManager.shared.signIn { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let msalResult):
                    let email = msalResult.account.username ?? ""
                    
                    userData.user.email = email
                    userData.user.firstName = "Sarah"
                    userData.user.lastName = "Svitlik"
                    
                    
                    appVariables.isLoggedIn = true
                    appVariables.showLoginPage = false
                    
                case .failure(let error):
                    print("Sign-in error: \(error)")
                }
            }
        }
    }
}
