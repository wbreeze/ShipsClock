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
    
    /*:
     Play the bell sound for the given watch
     
     Thanks to [Akbar Khan](https://stackoverflow.com/users/8907542/akbar-khan) for SO answer [How to play a sound in Swift](https://stackoverflow.com/a/57036675)
     */
    func ringShipsBell(soundFile sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "wav") else {
            return
        }
        let audioPlayer = AVPlayer(url: url)
        audioPlayer.play()
    }
    
    func halfHourIndex(forTimeInSeconds time: Int) -> Int {
        return time / thirtyMinutes
    }
}
