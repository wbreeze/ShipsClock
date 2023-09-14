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
    
    private var foregroundRinger: BellRinger
    private var ticker: Timer?
    var model: ClockModel
    private var location: LocationTracker

    private let tickInterval = 1.0 // seconds
    
    init() {
        foregroundRinger = BellRinger()
        location = LocationTracker()
        model = ClockModel(locationTracker: location)
    }
    
    func prepareForStart() {
        location.seekPermission()
        foregroundRinger.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
    }
    
    private func shutdownForeground() {
        ticker?.invalidate()
        location.deactivate()
    }
    
    func prepareForShutdown() {
        shutdownForeground()
    }
    
    func moveToForeground() {
        model.updateClock()
        ticker = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true, block: updateTimeCallback)
        location.activate()
    }
    
    func moveToBackground() {
        shutdownForeground()
    }
    
    private func updateTimeCallback(_: Timer) {
        updateState()
    }
    
    func updateState() {
        model.updateClock()
        foregroundRinger.maybeRing(forTimeInSeconds: model.timeOfDayInSeconds)
    }
}
