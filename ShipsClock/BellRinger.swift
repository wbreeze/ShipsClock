//
//  TimerRinger.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 5/11/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import UIKit
import AVFoundation

class BellRinger {
    private var lastPlayedIndex = 0
    private var audioSession : AVAudioSession
    private var audioPlayer: AVAudioPlayer?
    private var bell: BellSoundFile

    init(bell: BellSoundFile) {
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
    func ring(hourIndex index: Int) {
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
    
    func initializeLastPlayed(forTimeInSeconds time: Int) {
        lastPlayedIndex = bell.halfHourIndex(forTimeInSeconds: time)
    }
    
    func maybeRing(forTimeInSeconds time: Int) {
        let bellIndex = bell.halfHourIndex(forTimeInSeconds: time)
        if (bellIndex != lastPlayedIndex) {
            ring(hourIndex: bellIndex)
            lastPlayedIndex = bellIndex
        }
    }
}
