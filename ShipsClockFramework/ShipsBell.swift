//
//  ShipsBell.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 5/2/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import UIKit
import AVFoundation

public struct ShipsBell {
    let thirtyMinutes = 30 * 60
    let fourHours = 4 * 60 * 60
    let soundsDir = "sounds"
    let bells = ["bell_eight", "bell_one", "bell_two", "bell_three", "bell_four", "bell_five", "bell_six", "bell_seven"]

    public init() {}
    
    public func soundFileName(bellIndex index: Int) -> String {
        return soundFileBaseName(bellIndex: index) + ".wav"
    }
    
    public func soundFileBaseName(bellIndex index: Int) -> String {
        return soundsDir + "/" + bells[index % 8]
    }
    
    public func halfHourIndex(forTimeInSeconds time: Int) -> Int {
        return (time % fourHours) / thirtyMinutes
    }
    
    public struct HourStrike {
        public let timing: DateComponents
        public let bellSound: String
    }
    
    public func bellSchedule() -> [HourStrike] {
        return (0...47).map { halfHour in
            var dateComponents = DateComponents()
            dateComponents.hour = halfHour / 2
            dateComponents.minute = (halfHour % 2) * 30
            return HourStrike(timing: dateComponents, bellSound: soundFileName(bellIndex: halfHour))
        }
    }
}
