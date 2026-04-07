//
//  Login.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/24/25.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var appVariables: AppVariables
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        VStack {
            Image("wnhu")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .shadow(radius: 8)
                .padding(.bottom, 20)
            
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
            .padding(.top, 20)
        }
    }
}

#Preview {
    Login()
}

