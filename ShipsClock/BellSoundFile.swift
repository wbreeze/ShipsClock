//
//  BellSoundFile.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 5/2/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import UIKit
import AVFoundation

struct BellSoundFile {
    let thirtyMinutes = 30 * 60
    let fourHours = 4 * 60 * 60
    let soundsDir = "sounds"
    let bells = ["bell_eight", "bell_one", "bell_two", "bell_three", "bell_four", "bell_five", "bell_six", "bell_seven"]

    func soundFileName(bellIndex index: Int) -> String {
        return soundFileBaseName(bellIndex: index) + ".wav"
    }
    
    func soundFileBaseName(bellIndex index: Int) -> String {
        return soundsDir + "/" + bells[index % 8]
    }
    
    func halfHourIndex(forTimeInSeconds time: Int) -> Int {
        return (time % fourHours) / thirtyMinutes
    }
}
