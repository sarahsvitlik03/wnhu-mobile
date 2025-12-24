//
//  SongModel.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/24/25.
//

import Foundation

struct SongModel: Codable {
    var id: String
    var title: String
    var artist: String
    var album: String
    var duration: String
    var imageURL: String
}
