//
//  NotifierRinger.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 5/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import Foundation
import UIKit
import ShipsClockFramework

class NotifierRinger: BellNotifier {
    var notificationCenter: UNUserNotificationCenter?
    let ringerCategoryID = UUID().uuidString
    var bell: ShipsBell

    init(bell: ShipsBell) {
        self.bell = bell
    }
    
    private func center() -> UNUserNotificationCenter {
        if let center = notificationCenter {
            return center
        } else {
            notificationCenter = UNUserNotificationCenter.current()
            return notificationCenter!
        }
    }
    
    override func seekPermission() {
        center().requestAuthorization(options: [.sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization is \(String(describing: error))")
            }
        }
    }
    
    override func disableNotifications() {
        center().removeAllPendingNotificationRequests()
    }
    
    override func scheduleBellNotificationsIfAuthorized() {
        center().getNotificationSettings { settings in
            if (settings.authorizationStatus == .authorized) {
                for period in self.bell.bellSchedule() {
                    self.scheduleBellNotification(matching: period.timing, withSound: period.bellSound)
                }
            }
        }
    }
    
    fileprivate func scheduleBellNotification(matching dateComponents: DateComponents, withSound sound: String) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound(named: UNNotificationSoundName(sound))
        content.categoryIdentifier = ringerCategoryID
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        center().add(request) { (error) in
           if error != nil {
              print("Didn't add the notification, error \(String(describing: error))")
           }
        }
    }
}
