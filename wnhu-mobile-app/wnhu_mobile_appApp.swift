//
//  wnhu_mobile_appApp.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/23/25.
//

import SwiftUI

@main
struct wnhu_mobile_appApp: App {
    @StateObject var app = AppVariables()
    @StateObject var songData = SongData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppVariables())
                .environmentObject(songData)
                .preferredColorScheme(.dark)
                .environmentObject(SongData())
        }
    }
}
