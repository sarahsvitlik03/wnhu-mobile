//
//  RadioPlayer.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 1/5/26.
//

import AVFoundation
import SwiftUI

class RadioPlayer: ObservableObject {
    @Published var isPlaying: Bool = false
    private var player: AVPlayer?
    
    func startLocalMP3() {
        if let url = Bundle.main.url(forResource: "Heavy", withExtension: "mp3") {
            player = AVPlayer(url: url)
            player?.play()
            isPlaying = true
        } else {
            print("MP3 not found in bundle")
        }
    }
    
    /*  Use Later for Icecast stream
    func startStream () {
        guard let url = URL(string: "https://www.youtube.com/watch?v=1BCqCgamowo") else {return}
        player = AVPlayer (url: url)
        player?.play()
        isPlaying = true
        }  */
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
}
