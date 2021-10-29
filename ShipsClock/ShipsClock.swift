//
//  ShipsClock.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/21/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import Foundation
import ShipsClockFramework

/*:
 Application model for the Ships Clock
 */
class ShipsClock : ObservableObject {
    @Published var timeOfDayInSeconds = 0
    @Published var locationTracker: LocationTracker
    @Published var celestialComputer: CelestialComputer
    
    private var bell = ShipsBell()
    private var backgroundRinger: BellNotifier
    private var foregroundRinger: TimerRinger
    private var ticker: Timer?
    
    private let tickInterval = 1.0 // seconds
    
    init() {
        timeOfDayInSeconds = ShipsClock.nextTime()
        foregroundRinger = TimerRinger(bell: bell)
        if #available(iOS 15.0, *) {
            backgroundRinger = WidgetRinger()
        } else {
            backgroundRinger = NotifierRinger(bell: bell)
        }
        let lt = LocationTracker()
        locationTracker = lt
        celestialComputer = CelestialComputer(locationTracker: lt)
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
        updateTime() // right away, not at next tick
        ticker = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true, block: updateTimeCallback)
        locationTracker.activate()
    }
    
    func moveToBackground() {
        ticker?.invalidate()
        backgroundRinger.scheduleBellNotificationsIfAuthorized()
        locationTracker.deactivate()
    }

    private func updateTimeCallback(_: Timer) {
        updateTime()
    }

    private func updateTime() {
        timeOfDayInSeconds = ShipsClock.nextTime()
        celestialComputer.maybeUpdateTheSky(timeOfDayInSeconds: timeOfDayInSeconds)
        foregroundRinger.maybeRing(forTimeInSeconds: timeOfDayInSeconds)
    }
    
    private static func nextTime() -> Int {
        return CalendarTime.timeOfDayInSeconds()
    }
}
