//
//  ShipsClock.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/21/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import Foundation

/*:
 Application model for the Ships Clock
 */
class ShipsClock : ObservableObject {
    @Published var timeOfDayInSeconds = 0
    private var ticker: Timer?
    
    private let tickInterval = 1.0 // seconds
    
    init() {
        nextTime()
    }
    
    deinit {
        ticker?.invalidate()
    }
    
    func start() {
        ticker = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true, block: updateTime)
    }
    
    private func updateTime(timer: Timer) {
        nextTime()
    }
    
    private func nextTime() {
        let now = Date()
        let cal = Calendar.current
        let hms = cal.dateComponents([.hour, .minute, .second], from: now)
        if let hour = hms.hour, let minute = hms.minute, let second = hms.second {
            timeOfDayInSeconds = (hour * 60 + minute) * 60 + second
        }
    }
}
