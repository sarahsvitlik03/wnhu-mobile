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
    
    func updateFromIcecast() async {
           do {
               let raw = try await IcecastService.fetchCurrentTrack()
               let parsed = parseTrack(raw)
               self.song = SongModel(
                   song: parsed.title,
                   artist: parsed.artist,
                   album: self.song.album,
                   genre: self.song.genre,
                   releaseDate: self.song.releaseDate,
                   duration: self.song.duration,
                   imageURL: self.song.imageURL
               )
               await updateFromAPI()
           } catch {
               print("Icecast error:", error)
           }
       }

       func startAutoRefresh() {
           Task {
               while true {
                   await updateFromIcecast()
                   try? await Task.sleep(nanoseconds: 15_000_000_000)
               }
           }
       }
   }

