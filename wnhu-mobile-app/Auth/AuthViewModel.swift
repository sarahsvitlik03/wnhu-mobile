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
                
                    /* Check backend if user exists */
                    self.checkIfUserExists(email: email, completion: { exists in
                        DispatchQueue.main.async {
                            if exists {
                                appVariables.isLoggedIn = true
                                appVariables.showLoginPage = false
                            } else {
                                appVariables.showProfileSetup = true
                                appVariables.showLoginPage = false
                            }
                        }
                    })

                case .failure(let error):
                    print("Sign-in error: \(error)")
                }
            }
        }
    }
    
    /* Checks backend if the user already exists*/
    func checkIfUserExists (email: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:3000/checkUser") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let exists = (String(data: data, encoding: .utf8) == "exists")
            DispatchQueue.main.async {
                completion(exists)
            }
        } .resume()
        
    }
}

