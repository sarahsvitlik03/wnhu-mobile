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
    
    func startMP3() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }

        if let url = Bundle.main.url(forResource: "Heavy", withExtension: "mp3") {
            player = AVPlayer(url: url)
            player?.play()
            isPlaying = true
        } else {
            print("MP3 not found")
        }
    }
    
    func startStream() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }

        guard let url = URL(string: "https://wnhu-stream1.newhaven.edu:8051/stationengine") else {
            print("Invalid stream URL")
            return
        }

        player = AVPlayer(url: url)
        player?.play()
        isPlaying = true
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }
    
}
