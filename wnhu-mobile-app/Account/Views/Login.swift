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
            Text("Login to WNHU 88.4")
                Button(action: {
                    auth.signIn(appVariables: appVariables, userData: userData)
        }) {
            Text("Sign in with Microsoft")
            /* I need to add a database check here, where if the user does not have an entry in our database, it will go to the profile setup page */
            

            }
        }
    }
}

#Preview {
    Login()
}

/* Function to check user exists */
