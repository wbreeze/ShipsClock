//
//  ShipsClock.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/21/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import Foundation

/**
Application controller for the Ships Clock
 */
class ShipsClock {
    
    private var bell = ShipsBell()
    private var backgroundRinger: NotifierRinger
    private var foregroundRinger: TimerRinger
    private var ticker: Timer?
    var model: ClockModel
    private var location: LocationTracker

    private let tickInterval = 1.0 // seconds
    
    init() {
        foregroundRinger = TimerRinger(bell: bell)
        backgroundRinger = NotifierRinger(bell: bell)
        location = LocationTracker()
        model = ClockModel(locationTracker: location)
    }
    
    func prepareForStart() {
        backgroundRinger.seekPermission()
        location.seekPermission()
        foregroundRinger.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
    }
    
    private func shutdownForeground() {
        ticker?.invalidate()
        location.deactivate()
    }
    
    func prepareForShutdown() {
        shutdownForeground()
        backgroundRinger.disableNotifications()
    }
    
    func moveToForeground() {
        backgroundRinger.disableNotifications()
        model.updateClock()
        ticker = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true, block: updateTimeCallback)
        location.activate()
    }
    
    func moveToBackground() {
        shutdownForeground()
        backgroundRinger.scheduleBellNotificationsIfAuthorized()
    }
    
    private func updateTimeCallback(_: Timer) {
        updateState()
    }
    
    func updateState() {
        model.updateClock()
        foregroundRinger.maybeRing(forTimeInSeconds: model.timeOfDayInSeconds)
    }
}
