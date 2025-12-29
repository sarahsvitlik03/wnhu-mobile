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
    
    var body: some View {
        VStack {
            Image("wnhu")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .shadow(radius: 8)
            // OR change this to display the current show or genre, or both
            //Code for recieiving URL from iTunes API -> Work on later
            AsyncImage(url: URL(string: SongData.song.imageURL)) {
                image in image.resizable().scaledToFit()
            } placeholder: {
                Image("bluebird")
                .resizable()
                .scaledToFit() }
                .cornerRadius(14)
                .padding(.horizontal, 30)
                .shadow(radius: 8)
                .padding(.top, 20)
                .padding(.bottom, 20)

            
            VStack(spacing: 4) {
                Text(SongData.song.title)
                    .font(.title3.weight(.medium))
                Text(SongData.song.artist)
                    .foregroundColor(.secondary)
                Text(SongData.song.album)
                    .foregroundColor(.secondary)
                
                HStack {
                    HStack {
                        Button (action: {
                            isThumbsDown.toggle()
                            if isThumbsUp == true {
                                isThumbsUp.toggle() // If thumbs up is pressed, toggle it
                            }
                        }){ label: do {
                            Image(systemName: isThumbsDown ? "hand.thumbsdown.fill" :"hand.thumbsdown")
                                .font(.system(size: 20))
                                .padding(.top, 20)
                                .padding(.trailing, 50)
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
                        }
                    }
                            HStack {
                                Button (action: {
                                    isPlaying.toggle() //turns on and off
                                }){ label: do {
                                    Image(systemName: isPlaying ? "play.circle" : "pause.circle")
                                        .font(.system(size: 70))
                                        .padding(.top, 20)
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [
                                                    Color(red: 0.98, green: 0.25, blue: 0.25),
                                                    Color(red: 0.60, green: 0.00, blue: 0.00)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ))}
                                }
                                HStack {
                                    Button (action: {
                                        isThumbsUp.toggle()
                                        if isThumbsDown == true {
                                            isThumbsDown.toggle() // If thumbs down is pressed, toggle it
                                        }
                                    }){ label: do {
                                        Image(systemName: isThumbsUp ? "hand.thumbsup.fill" :"hand.thumbsup")
                                            .font(.system(size: 20))
                                            .padding(.top, 20)
                                            .padding(.leading, 50)
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
                                    }
                                }
                            }
                            // Connect iTunes API to this project, no icecast yet, but just feed it the song name from the songData file for now.
                            // Get Album cover, song, artist, and album all from iTunes API 
                        }
                    }
                }
            }
        }
    
    #Preview {
        Stream()
    }

