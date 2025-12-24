//
//  Stream.swift
//  wnhu-mobile
//
//  Created by Sarah Svitlik on 12/23/25.
//

import SwiftUI

struct Stream: View {
    var body: some View {
        VStack {
                Text("WNHU 88.4")
                .font(.system(size: 20, weight: .medium))
                    .kerning(1.0)

                    
                // OR change this to display the current show or genre, or both            
            //Code for recieiving URL from iTunes API -> Work on later
            AsyncImage(url: URL(string: SongData.song.imageURL)) {
                image in image.resizable().scaledToFit()
            } placeholder: {
                Image("bluebird")
                    .padding(.top, 10)
            }
            
            VStack {
                Text(SongData.song.title)
                    .padding(.top, 25)
                Text(SongData.song.artist)
                    .padding(.top, 1)
                Text(SongData.song.album)
                    .padding(.top, 1)
                HStack {
                    Image(systemName: "hand.thumbsdown")
                        .font(.system(size: 20))
                        .padding(.top, 20)
                        .padding(.trailing, 50)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color(red: 0.95, green: 0.15, blue: 0.15), Color(red: 0.6, green: 0.0, blue: 0.0), .black],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    Image(systemName: "play.circle")
                        .font(.system(size: 70))
                        .padding(.top, 20)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color(red: 0.95, green: 0.15, blue: 0.15), Color(red: 0.6, green: 0.0, blue: 0.0), .black],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    Image(systemName: "hand.thumbsup")
                        .font(.system(size: 20))
                        .padding(.top, 20)
                        .padding(.leading, 50)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color(red: 0.95, green: 0.15, blue: 0.15), Color(red: 0.6, green: 0.0, blue: 0.0), .black],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
            }
                // When you press on the play button, it should change into the paused icon
                // when you press like / dislike, the color fill it plus show an alert
        }
    }
}

#Preview {
    Stream()
}
