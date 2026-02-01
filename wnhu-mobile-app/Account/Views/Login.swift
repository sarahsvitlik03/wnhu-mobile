//
//  Login.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/24/25.
//

import SwiftUI

/* Make this the first page to the app -> Verify user and login */
struct Login: View {
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var appVariables: AppVariables
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            Text("")
                Button(action: {
                    auth.signIn(appVariables: appVariables, userData: userData)
        }) {
            Text("Sign in with Microsoft")
            }
            
            Button( action: {
                appVariables.isGuest = true
            }) {
                Text("Sign in as Guest")
            }
            .padding(.top, 10)
        }
    }
}

#Preview {
    Login()
}

