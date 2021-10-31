//
//  TimerRinger.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 5/11/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import UIKit
import AVFoundation
import ShipsClockFramework

public struct TimerRinger {
    let thirtyMinutes = 30 * 60
    let fourHours = 4 * 60 * 60
    
    var lastPlayedIndex = 0
    var audioSession : AVAudioSession
    var audioPlayer: AVAudioPlayer?
    var bell: ShipsBell
    
    public init(bell: ShipsBell) {
        self.bell = bell
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
    public mutating func ring(hourIndex index: Int) {
        if let url = Bundle.main.url(forResource: bell.soundFileBaseName(bellIndex: index), withExtension: "wav") {
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
    
    public mutating func initializeLastPlayed(forTimeInSeconds time: Int) {
        lastPlayedIndex = bell.halfHourIndex(forTimeInSeconds: time)
    }
    
    public mutating func maybeRing(forTimeInSeconds time: Int) {
        let bellIndex = bell.halfHourIndex(forTimeInSeconds: time)
        if (bellIndex != lastPlayedIndex) {
            ring(hourIndex: bellIndex)
            lastPlayedIndex = bellIndex
        }
    }
}
