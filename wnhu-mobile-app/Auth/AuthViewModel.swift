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
    @Published var userData = UserData()

    func signIn() {
        AuthManager.shared.signIn { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let msalResult):
                    let email = msalResult.account.username ?? ""

                    // Fill your local UserModel with MSAL data
                    self.userData.user.email = email
                    self.userData.user.username = email
                    self.userData.user.firstName = ""
                    self.userData.user.lastName = ""
                    self.userData.user.joinedDate = "01/14/2026"

                    self.isSignedIn = true

                case .failure(let error):
                    print("Sign-in error: \(error)")
                }
            }
        }
    }
}
