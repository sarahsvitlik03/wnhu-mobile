//
//  SongModel.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/24/25.
//

import Foundation

struct SongModel: Identifiable, Codable {
    let id = UUID()
    let song: String
    let artist: String
    let album: String
    let genre: String
    let releaseDate: String
    let duration: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case song = "trackName"
        case artist = "artistName"
        case album = "collectionName"
        case genre = "primaryGenreName"
        case releaseDate = "releaseDate"
        case duration = "trackTimeMillis"
        case imageURL = "artworkUrl100"
    }
}

extension SongModel {
    var highResArtwork: String {
        imageURL.replacingOccurrences(of: "100x100", with: "600x600")
    }
}
