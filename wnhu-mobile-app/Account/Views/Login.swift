//
//  Login.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/24/25.
//

import SwiftUI
/* Make this the firts page to the app -> Verify user and login */

struct Login: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        VStack {
            Text("Login to WNHU 88.4")
                Button(action: {
                    auth.signIn()
        }) {
            Text("Sign in with Microsoft")
            }
        }
    }
}

#Preview {
    Login()
}
