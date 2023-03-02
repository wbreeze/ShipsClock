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
    
    override func moveToForeground() {
        super.moveToForeground()
        backgroundRinger.disableNotifications()
        foregroundRinger.initializeLastPlayed(forTimeInSeconds: timeOfDayInSeconds)
        locationTracker.activate()
    }
    
    override func moveToBackground() {
        super.moveToBackground()
        backgroundRinger.scheduleBellNotificationsIfAuthorized()
        locationTracker.deactivate()
    }

    override func updateClock() {
        super.updateClock()
        celestialComputer.maybeUpdateTheSky(timeOfDayInSeconds: timeOfDayInSeconds)
        foregroundRinger.maybeRing(forTimeInSeconds: timeOfDayInSeconds)
    }
}
