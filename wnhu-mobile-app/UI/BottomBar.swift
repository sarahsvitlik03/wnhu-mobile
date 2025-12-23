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
    
    let StreamView: AnyView
    let AccountView: AnyView
    
    init(
        _ StreamView : AnyView,
        _ AccountView : AnyView
    ){
        self.StreamView = StreamView
        self.AccountView = AccountView
    }
    
    var body: some View {
        TabView (selection: $app.selectedTab) {
            StreamView
                .tabItem {
                    Text("Stream")
                    Image(systemName: "dot.radiowaves.left.and.right")
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
                AnyView(Stream()),
                AnyView(Account())
            )
            .environmentObject(AppVariables())
        }
}
