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
            //Code for recieiving URL from iTunes API -> Work on later
            AsyncImage(url: URL(string: SongData.song.imageURL)) {
                image in image.resizable().scaledToFit()
            } placeholder: {
                Image("bluebird")
                    .padding(.top, 50)
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
                        .padding(.trailing, 30)
                    Image(systemName: "play.circle")
                        .font(.system(size: 70))
                        .padding(.top, 20)
                    Image(systemName: "hand.thumbsup")
                        .font(.system(size: 20))
                        .padding(.top, 20)
                        .padding(.leading, 30)
                }
            }
            // Display square for photo -> Have random image first
            // Display name name from Song Data
            // Display artist name
            // Display play button with like and dislike on the side 
        }
    }
}

#Preview {
    Stream()
}
