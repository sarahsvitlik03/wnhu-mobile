//
//  ContentView.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/23/25.
//

import SwiftUI

class AppVariables: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var isLoggedIn: Bool = false
    @Published var showLoginPage: Bool = true
    @Published var showProfileSetup: Bool = false
}

struct ContentView: View {
    @EnvironmentObject var appVariables: AppVariables

    var body: some View {
        ZStack {
            if appVariables.isLoggedIn { // If logged in == true then show
                BottomBar(
                    AnyView(Stream()),
                    AnyView(Account())
                )
                .transition(.opacity)
            } else if appVariables.showLoginPage == true {
                Login() // if show login page is true, the show. Which it is at the start
                    .transition(.opacity)
            }
            else if appVariables.showProfileSetup == true {
                ProfileSetup()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppVariables())
    }
}
