//
//  ShipsBell.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 5/2/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import UIKit
import AVFoundation

struct ShipsBell {
    let thirtyMinutes = 30 * 60
    let fourHours = 4 * 60 * 60
    let soundsDir = "sounds"
    let bells = ["bell_eight", "bell_one", "bell_two", "bell_three", "bell_four", "bell_five", "bell_six", "bell_seven"]
    
    var lastPlayedIndex = 0
    var audioSession : AVAudioSession
    var audioPlayer: AVAudioPlayer?
    
    init() {
        audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: .mixWithOthers)
        } catch {
            print("Failed to set audio session category.")
        }
    }
    
    /*:
     Play the bell sound for the given half hour interval
     */
    mutating func ring(soundFile sound: String) {
        if let url = Bundle.main.url(forResource: soundsDir + "/" + sound, withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: url)
                try audioSession.setActive(true)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch let error as NSError {
                print("Failed play audio \(error)")
            }
        }
    }
    
    func halfHourIndex(forTimeInSeconds time: Int) -> Int {
        return (time % fourHours) / thirtyMinutes
    }
    
    mutating func initializeLastPlayed(forTimeInSeconds time: Int) {
        lastPlayedIndex = halfHourIndex(forTimeInSeconds: time)
    }
    
    mutating func maybeRing(forTimeInSeconds time: Int) {
        let bellIndex = halfHourIndex(forTimeInSeconds: time)
        if (bellIndex != lastPlayedIndex) {
            ring(soundFile: bells[bellIndex])
            lastPlayedIndex = bellIndex
        }
    }
}
