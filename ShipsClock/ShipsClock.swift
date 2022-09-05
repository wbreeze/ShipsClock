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
class ShipsClock : ClockModel {
    @Published var locationTracker: LocationTracker
    @Published var celestialComputer: CelestialComputer
    
    private var bell = ShipsBell()
    private var backgroundRinger: NotifierRinger
    private var foregroundRinger: TimerRinger
    private var ticker: Timer?
    
    private let tickInterval = 1.0 // seconds
    
    override init() {
        foregroundRinger = TimerRinger(bell: bell)
        backgroundRinger = NotifierRinger(bell: bell)
        let lt = LocationTracker()
        locationTracker = lt
        celestialComputer = CelestialComputer(locationTracker: lt)
        super.init()
        timeOfDayInSeconds = ShipsClock.nextTime()
        utcTimeInSeconds = ShipsClock.utcTime()
    }
    
    func prepareForStart() {
        backgroundRinger.seekPermission()
        locationTracker.seekPermission()
        foregroundRinger.initializeLastPlayed(forTimeInSeconds: timeOfDayInSeconds)
    }
    
    func prepareForShutdown() {
        moveToBackground()
        backgroundRinger.disableNotifications()
    }
    
    func moveToForeground() {
        backgroundRinger.disableNotifications()
        foregroundRinger.initializeLastPlayed(forTimeInSeconds: ShipsClock.nextTime())
        updateClock() // right away, not at next tick
        ticker = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true, block: updateTimeCallback)
        locationTracker.activate()
    }
    
    func moveToBackground() {
        ticker?.invalidate()
        backgroundRinger.scheduleBellNotificationsIfAuthorized()
        locationTracker.deactivate()
    }

    private func updateTimeCallback(_: Timer) {
        updateClock()
    }
    
    private func updateClock() {
        timeOfDayInSeconds = ShipsClock.nextTime()
        utcTimeInSeconds = ShipsClock.utcTime()
        celestialComputer.maybeUpdateTheSky(timeOfDayInSeconds: timeOfDayInSeconds)
        foregroundRinger.maybeRing(forTimeInSeconds: timeOfDayInSeconds)
    }
    
    fileprivate static func timeInSeconds(_ hms: DateComponents) -> Int {
        if let hour = hms.hour, let minute = hms.minute, let second = hms.second {
            return (hour * 60 + minute) * 60 + second
        } else {
            return 0
        }
    }
    
    fileprivate static func timeInSeconds(_ cal: Calendar) -> Int {
        let now = Date()
        let hms = cal.dateComponents([.hour, .minute, .second], from: now)
        return timeInSeconds(hms)
    }
    
    private static func nextTime() -> Int {
        return timeInSeconds(Calendar.current)
    }

    private static func utcTime() -> Int {
        var cal = Calendar.current
        cal.timeZone = TimeZone.init(secondsFromGMT: 0) ?? TimeZone.current
        return timeInSeconds(cal)
    }
}
