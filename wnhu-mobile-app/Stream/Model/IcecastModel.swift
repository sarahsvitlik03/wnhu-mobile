//
//  IcecastModel.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 3/26/26.
//

import Foundation

struct IcecastModeL: Decodable {
    struct Source: Decodable {
        let server_name: String?
        let title: String?
        let currently_playing: String?
    }
    struct IcecastSource: Decodable {
        let source: [Source] // this is the json data that we will parse from icecast
    }
    let icestats: IcecastSource
}

enum IcecastService {
    static func fetchCurrentTrack() async throws -> String {
        let url = URL(string: "https://wnhu-stream1.newhaven.edu:8051/status-json.xsl")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(IcecastModeL.self, from: data)
        
        guard let spl = decoded.icestats.source.first(where: { $0.server_name == "WNHU Station Engine" }) else {
            throw NSError(domain: "Icecast", code: 0)
        }

        return spl.currently_playing ?? spl.title ?? ""
    }
}

/* parse icecast data */
func parseTrack(_ raw: String) -> (artist: String, title: String) {
    let parts = raw.split(separator: "-", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespaces) }
    if parts.count == 2 {
        return (artist: parts[0], title: parts[1])
    }
    return ("", raw)
}
