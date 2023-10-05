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
        ringer.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
        foregroundTicker = TimerTicker(clock: model, bell: ringer)
        backgroundRinger = NotifierRinger(bell: bellSound)
    }
    
    func prepareForStart() {
        backgroundRinger.seekPermission()
        location.seekPermission()
    }
        
    func prepareForShutdown() {
        foregroundTicker.stopTicking()
        backgroundRinger.disableNotifications()
        location.deactivate()
    }
    
    func moveToForeground() {
        backgroundRinger.disableNotifications()
        location.activate()
        model.updateClock()
        ringer.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
        foregroundTicker.startTicking()
    }
    
    func moveToBackground() {
        foregroundTicker.stopTicking()
        location.deactivate()
        backgroundRinger.scheduleBellNotificationsIfAuthorized()
    }
}
