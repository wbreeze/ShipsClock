//
//  NotifierRinger.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 5/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import Foundation
import UIKit

class NotifierRinger: NSObject, UNUserNotificationCenterDelegate {
    var notificationID: String?
    var notificationCenter: UNUserNotificationCenter?
    let ringerCategoryID = UUID().uuidString
    let silenceActionID = UUID().uuidString
    let multiActionID = UUID().uuidString

    private func center() -> UNUserNotificationCenter {
        if let center = notificationCenter {
            return center
        } else {
            notificationCenter = UNUserNotificationCenter.current()
            return notificationCenter!
        }
    }
    
    func registerNotificationActions() {
        print("Register notification actions")

        // Define the custom actions.
        let silenceAction = UNNotificationAction(identifier: silenceActionID,
                                                 title: "Silence",
                                                 options: [])
        let secondAction = UNNotificationAction(identifier: multiActionID,
                                                 title: "Or this",
                                                 options: [])

        // Define the notification type
        let shipsBellCategory = UNNotificationCategory(identifier: ringerCategoryID, actions: [silenceAction, secondAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "Previews hidden", options: .customDismissAction)

        // Set self as delegate and register the notification type.
        center().delegate = self
        center().setNotificationCategories([shipsBellCategory])
    }
    
    func seekPermission() {
        center().requestAuthorization(options: [.sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization is \(String(describing: error))")
            }
        }
    }
    
    func disableNotifications() {
        if let nid = notificationID {
            print("Removing notification \(nid)")
            center().removePendingNotificationRequests(withIdentifiers: [nid])
        }
    }
    
    func scheduleBellNotificationIfAuthorized() {
        center().getNotificationSettings { settings in
            if (settings.authorizationStatus == .authorized) {
                self.scheduleBellNotification()
            }
        }
    }
    
    fileprivate func scheduleBellNotification() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Watch progress"
        content.body = "One bell"
        content.userInfo = ["aps" : [
            "category" : ringerCategoryID,
            "alert" : [
                "title" : "Ships Bell",
                "body" : "One bell"
            ],
            ],]
        content.sound = UNNotificationSound(named: UNNotificationSoundName("sounds/bell_one.wav"))
        content.categoryIdentifier = ringerCategoryID
        notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID!,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        print("Adding notification")
        center().add(request) { (error) in
           if error != nil {
              print("Didn't add the notification, error \(String(describing: error))")
           }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                didReceive response: UNNotificationResponse,
                withCompletionHandler completionHandler:
                   @escaping () -> Void) {
        print("Notification response \(String(describing: response))")
        switch response.actionIdentifier {
          case silenceActionID:
             break
          default:
             scheduleBellNotification()
             break
       }
       // Always call the completion handler when done.
       completionHandler()
    }

}
