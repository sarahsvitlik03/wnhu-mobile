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
    var formattedReleaseDate: String { // reformat date
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: releaseDate) else { return releaseDate }
        
        let output = DateFormatter()
        output.dateStyle = .medium  // normal date style
        return output.string(from: date)
    }
    
    var releaseYear: String {
        String(formattedReleaseDate.prefix(4))
    }
            var formattedDuration: String {
            let totalSeconds = duration / 1000
            let minutes = totalSeconds / 60
            let seconds = totalSeconds % 60
            return String(format: "%d:%02d", minutes, seconds)
    }

}
