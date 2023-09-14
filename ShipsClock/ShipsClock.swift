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
    private var ringer: BellRinger
    private var location: LocationTracker
    private var foregroundTicker: TimerTicker
    var model: ClockModel

    init() {
        ringer = BellRinger()
        location = LocationTracker()
        model = ClockModel(locationTracker: location)
        foregroundTicker = TimerTicker(clock: model, bell: ringer)
    }
    
    func prepareForStart() {
        location.seekPermission()
        model.updateClock()
        ringer.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
    }
    
    private func shutdownForeground() {
        foregroundTicker.stopTicking()
        location.deactivate()
    }
    
    func prepareForShutdown() {
        shutdownForeground()
    }
    
    func moveToForeground() {
        model.updateClock()
        location.activate()
        foregroundTicker.startTicking()
    }
    
    func moveToBackground() {
        shutdownForeground()
    }
}
