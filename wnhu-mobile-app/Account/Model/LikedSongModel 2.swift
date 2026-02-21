//
//  LikedSongModel.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 1/10/26.
//

import Foundation

struct LikedSongModel: Identifiable {
    let id: UUID = UUID()
    // liked song
    var songName: String
    var artistName: String
}

