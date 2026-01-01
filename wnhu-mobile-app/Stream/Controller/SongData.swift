//
//  SongData.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/24/25.
//
// This is just harded coded data before we get the app reading icecast metadata

import Foundation

struct SongData: {
    static var song = SongModel(
        song: "Bluebird",
        artist: "Lana Del Rey",
        album: "Unknown",
        genre: "Alternative",
        releaseDate: "April 18th, 2025",
        duration: 3,
        imageURL: ""
    )
    
    @MainActor
    func updateFromAPI() async {
        do {
            if let song = try await iTunesAPI.fetchSongInfo(
                title: SongData.song.song,
                artist: SongData.song.artist
            ) {
                SongData.song = song
            }
        } catch {
            print("API error:", error)
        }
    }
}
