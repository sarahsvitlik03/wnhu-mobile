//
//  Stream.swift
//  wnhu-mobile
//
//  Created by Sarah Svitlik on 12/23/25.
//

import SwiftUI

struct Stream: View {
    
    @State private var isPlaying = true
    @State private var isThumbsUp = false
    @State private var isThumbsDown = false
    @State private var isInfoShowing = false
    @EnvironmentObject var songData: SongData
    @StateObject private var radio = RadioPlayer() //for pause/play buttons
    @EnvironmentObject var player: RadioPlayer
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            VStack {
                Button(action: {
                    isInfoShowing.toggle()
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundColor(.secondary)
                        .shadow(radius: 8)
                }
                .padding(.leading, 300)
                .padding(.bottom, -10)
                .popover(isPresented: $isInfoShowing) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(songData.song.song)
                            .font(.title3.weight(.medium))
                        Text("Artist: \(songData.song.artist)")
                            .foregroundColor(.secondary)
                        Text("Album: \(songData.song.album)")
                            .foregroundColor(.secondary)
                        Text("Genre: \(songData.song.genre)")
                            .foregroundColor(.secondary)
                        Text("Release date: \(songData.song.formattedReleaseDate)")
                            .foregroundColor(.secondary)
                        Text("Duration: \(songData.song.formattedDuration)")
                            .foregroundColor(.secondary)

                    }
                    .padding()
                }
            }

            Image("wnhu")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .shadow(radius: 8)
            // OR change this to display the current show or genre, or both
            AsyncImage(url: URL(string: songData.song.highResArtwork)) { image in
                image.resizable().scaledToFit() //get image from itunes
            } placeholder: {
                Image(songData.song.highResArtwork)
                    .resizable()
                    .scaledToFit()
            }
            .cornerRadius(14)
            .padding(.horizontal, 30)
            .shadow(radius: 8)
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            VStack(spacing: 4) {
                Text(songData.song.song)
                    .font(.title3.weight(.medium))
                Text(songData.song.artist)
                    .foregroundColor(.secondary)
                Text(songData.song.album)
                    .foregroundColor(.secondary)
                
                HStack(alignment: .center) {
                    
                    // Thumbs Down Button
                    Button(action: {
                        addDislikedSong()
                        isThumbsDown.toggle()
                        if isThumbsUp {
                            isThumbsUp.toggle()
                        }
                    }) {
                        Image(systemName: isThumbsDown ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                            .font(.system(size: 22))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.98, green: 0.25, blue: 0.25),
                                        Color(red: 0.60, green: 0.00, blue: 0.00)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    } .padding (.leading, 70)
                    Spacer(minLength: 24)

                    //Pause/Play Button
                    Button(action: {
                        isPlaying.toggle()
                        if isPlaying == true {
                            player.startStream()
                        }
                        else {
                            player.pause()
                        }
                        
                        print("stream starting")
                     }) {
                        Image(systemName: isPlaying ? "play.circle" : "pause.circle")
                            .font(.system(size: 70))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.98, green: 0.25, blue: 0.25),
                                        Color(red: 0.60, green: 0.00, blue: 0.00)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }

                    Spacer(minLength: 24)
                    
                    //Thumbs Up Button
                    Button(action: {
                        addLikedSong()
                        // Toggle the thumbs up button
                         isThumbsUp.toggle()
                        // If the user disliked the song, toggle again
                        if isThumbsDown {
                            isThumbsDown.toggle()
                        }
                    }) {
                        Image(systemName: isThumbsUp ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.system(size: 22))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.98, green: 0.25, blue: 0.25),
                                        Color(red: 0.60, green: 0.00, blue: 0.00)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    } .padding (.trailing, 70)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
                .padding(.bottom, 25)
                // Connect iTunes API to this project, no icecast yet, but just feed it the song name from the songData file for now.
            }
        }
        .task { //update song data for each new song
            await songData.updateFromAPI()
        }
    }
    func addLikedSong(completion: @escaping (Bool) -> Void = { _ in }) {
        guard let url = URL(string: "http://localhost:8000/likedSong") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let body: [String: Any] = [
            "title": songData.song.song, //title
            "artist": songData.song.artist,
            "email": userData.user.email
        ]
        
        print(body)
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let http = response as? HTTPURLResponse {
                completion(http.statusCode == 200)
            } else {
                completion(false)
            }
        } .resume()
      }
    
    func addDislikedSong(completion: @escaping (Bool) -> Void = { _ in }) {
        guard let url = URL(string: "http://localhost:8000/dislikedSong") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let body: [String: Any] = [
            "title": songData.song.song, //title
            "artist": songData.song.artist,
            "email": userData.user.email
        ]
        
        print(body)
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let http = response as? HTTPURLResponse {
                completion(http.statusCode == 200)
            } else {
                completion(false)
            }
        } .resume()
      }
}

#Preview {
    Stream()
        .environmentObject(SongData())
}
