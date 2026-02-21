//
//  DislikedSongModel.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 2/17/26.
//

import SwiftUI

struct DislikedSongModel: Identifiable {
    let id: UUID = UUID()
    // disliked song
    var songName: String
    var artistName: String
}
