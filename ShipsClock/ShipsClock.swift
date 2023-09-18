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
        print("RequestBackgroundTick doing just that.")
        let request = BGAppRefreshTaskRequest(identifier: "com.wbreeze.ShipsClock.updateMaybeRing")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 30) // seconds
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule background task: \(error)")
        }
        print("Request \(request) submitted")
    }
    
    func prepareForStart() {
        print("PrepareForStart seeking permission, updating clock, initializing last played")
        location.seekPermission()
        model.updateClock()
        ringer.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
    }
        
    func prepareForShutdown() {
        print("PrepareForShutdown stopping ticker, deactivating location")
        foregroundTicker.stopTicking()
        location.deactivate()
    }
    
    func moveToForeground() {
        print("MoveToForeground updating clock, activating location, starting ticker")
        model.updateClock()
        location.activate()
        foregroundTicker.startTicking()
    }
    
    func moveToBackground() {
        print("MoveToBackground stopping ticker, deactivating location, requesting BG processing")
        foregroundTicker.stopTicking()
        location.deactivate()
        requestBackgroundScheduledTick()
    }
}
