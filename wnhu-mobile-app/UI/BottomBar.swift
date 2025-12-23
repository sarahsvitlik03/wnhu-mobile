//
//  BottomBar.swift
//  wnhu-mobile
//
//  Created by Sarah Svitlik on 12/23/25.
//

import SwiftUI

struct BottomBar: View {
    @EnvironmentObject var app: AppVariables
    @State private var selectedTab = 0
    
    let HomeView: AnyView
    let AccountView: AnyView
    
    init(
        _ HomeView : AnyView,
        _ AccountView : AnyView
    ){
        self.HomeView = HomeView
        self.AccountView = AccountView
    }
    
    var body: some View {
        TabView (selection: $app.selectedTab) {
            HomeView
                .tabItem {
                    Text("Home")
                    Image(systemName: "house")
                }
                .tag(1)
            AccountView
                .tabItem {
                    Text("Account")
                    Image(systemName: "person.circle")
                }
                .tag(2)
        }
        .accentColor(CustomColors.red)
    }
}
    
    struct BottomBar_Previews: PreviewProvider {
        static var previews: some View {
            BottomBar(
                AnyView(Home()),
                AnyView(Account())
            )
            .environmentObject(AppVariables())
        }
}
