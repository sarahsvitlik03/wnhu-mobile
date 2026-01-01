//
//  SongData.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 12/24/25.
//
// This is just harded coded data before we get the app reading icecast metadata

import Foundation

@MainActor
class SongData: ObservableObject {
    @Published var song = SongModel( //Using this data right now to search and update phone with new songs. Eventually we wil need to replace w/ icecast
        song: "Heavy",
        artist: "The Marias",
        album: "",
        genre: "",
        releaseDate: "",
        duration: 3,
        imageURL: ""
    )
    
    func updateFromAPI() async {
        do {
            if let newSong = try await iTunesAPI.fetchSongInfo(
                title: song.song,
                artist: song.artist
            ) {
                self.song = newSong // replace whole song ^
            }
        } catch {
            print("API error:", error)
        }
    }

}
