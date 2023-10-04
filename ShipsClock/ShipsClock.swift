//
//  ShipsClock.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/21/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import Foundation
import BackgroundTasks

/**
Application controller for the Ships Clock
 */
class ShipsClock {
    var ringer: BellRinger
    var model: ClockModel

    private var location: LocationTracker
    private var foregroundTicker: TimerTicker
    private var backgroundRinger: NotifierRinger

    init() {
        let bellSound = BellSoundFile()
        ringer = BellRinger(bell: bellSound)
        location = LocationTracker()
        model = ClockModel(locationTracker: location)
        foregroundTicker = TimerTicker(clock: model, bell: ringer)
        backgroundRinger = NotifierRinger(bell: bellSound)
    }
    
    func prepareForStart() {
        print("PrepareForStart seeking permission, updating clock, initializing last played")
        backgroundRinger.seekPermission()
        location.seekPermission()
        model.updateClock()
        ringer.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
    }
        
    func prepareForShutdown() {
        print("PrepareForShutdown stopping ticker, deactivating location")
        foregroundTicker.stopTicking()
        backgroundRinger.disableNotifications()
        location.deactivate()
    }
    
    func moveToForeground() {
        print("MoveToForeground updating clock, activating location, starting ticker")
        backgroundRinger.disableNotifications()
        model.updateClock()
        location.activate()
        foregroundTicker.startTicking()
    }
    
    func moveToBackground() {
        print("MoveToBackground stopping ticker, deactivating location, requesting BG processing")
        foregroundTicker.stopTicking()
        location.deactivate()
        backgroundRinger.scheduleBellNotificationsIfAuthorized()
    }
}
