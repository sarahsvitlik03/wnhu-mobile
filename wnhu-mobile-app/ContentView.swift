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
            if appVariables.isLoggedIn {
                BottomBar(
                    AnyView(Stream()),
                    AnyView(Account())
                )
                .transition(.opacity)
            } else if appVariables.showLoginPage == true {
                Login()
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
