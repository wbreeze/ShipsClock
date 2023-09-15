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

    init() {
        ringer = BellRinger()
        location = LocationTracker()
        model = ClockModel(locationTracker: location)
        foregroundTicker = TimerTicker(clock: model, bell: ringer)
    }
    
    func requestBackgroundScheduledTick() {
        let request = BGProcessingTaskRequest(identifier: "com.wbreeze.ShipsClock.updateMaybeRing")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 10)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule background task: \(error)")
        }
    }
    
    func prepareForStart() {
        location.seekPermission()
        model.updateClock()
        ringer.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
    }
        
    func prepareForShutdown() {
        foregroundTicker.stopTicking()
        location.deactivate()
    }
    
    func moveToForeground() {
        model.updateClock()
        ringer.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
        location.activate()
        foregroundTicker.startTicking()
    }
    
    func moveToBackground() {
        foregroundTicker.stopTicking()
        requestBackgroundScheduledTick()
    }
}
