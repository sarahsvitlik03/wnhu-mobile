//
//  ContentView.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/23/25.
//

import SwiftUI

class AppVariables: ObservableObject {
    @Published var selectedTab: Int = 0
    // @Published var isLoggedIn: Bool = false
    // @Published var isSignedOut: Bool = false
}


struct ContentView: View {
    @EnvironmentObject var appVariables: AppVariables
        
        var body: some View {
        ZStack {
            BottomBar(
                AnyView(Home()),
                AnyView(Account()),
            )
            .transition(.opacity)
        }
    }
}

#Preview {
    ContentView().environmentObject(AppVariables())
}
