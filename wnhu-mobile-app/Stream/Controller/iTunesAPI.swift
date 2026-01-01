//
//  iTunesAPI.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 1/1/26.
//

import Foundation
 
struct iTunesAPI {
    static func fetchSongInfo(title: String, artist: String) async throws -> SongModel? {
        let query = "\(artist) \(title)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let urlString = "https://itunes.apple.com/search?term=\(query)&entity=song&limit=1"
        guard let url = URL(string: urlString) else { return nil }

        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(SearchResult.self, from: data)

        return result.results.first
    }
}

struct SearchResult: Codable {
    let results: [SongModel]
}
