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
    
    private var bell = ShipsBell()
    private var backgroundRinger: NotifierRinger
    private var foregroundRinger: TimerRinger
    private var ticker: Timer?
    
    private let tickInterval = 1.0 // seconds
    
    init() {
        timeOfDayInSeconds = ShipsClock.nextTime()
        foregroundRinger = TimerRinger(bell: bell)
        backgroundRinger = NotifierRinger(bell: bell)
    }
    
    func prepareForStart() {
        backgroundRinger.seekPermission()
        foregroundRinger.initializeLastPlayed(forTimeInSeconds: timeOfDayInSeconds)
    }
    
    func prepareForShutdown() {
        moveToBackground()
        backgroundRinger.disableNotifications()
    }
    
    func moveToForeground() {
        backgroundRinger.disableNotifications()
        foregroundRinger.initializeLastPlayed(forTimeInSeconds: ShipsClock.nextTime())
        ticker = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true, block: updateTime)
    }
    
    func moveToBackground() {
        ticker?.invalidate()
        backgroundRinger.scheduleBellNotificationsIfAuthorized()
    }
    
    private func updateTime(timer: Timer) {
        timeOfDayInSeconds = ShipsClock.nextTime()
        foregroundRinger.maybeRing(forTimeInSeconds: timeOfDayInSeconds)
    }
    
    private static func nextTime() -> Int {
        let now = Date()
        let cal = Calendar.current
        let hms = cal.dateComponents([.hour, .minute, .second], from: now)
        if let hour = hms.hour, let minute = hms.minute, let second = hms.second {
            return (hour * 60 + minute) * 60 + second
        } else {
            return 0
        }
    }
}
