//
//  AppDelegate.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import UIKit
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let clock = ShipsClock()

    func handleBackgroundUpdateMaybeRing(task: BGAppRefreshTask) {
        clock.requestBackgroundScheduledTick()

        task.expirationHandler = {
            print("Background refresh task expired before completion.")
        }

        DispatchQueue.main.async {
            let model = self.clock.model
            model.updateClock()
            self.clock.ringer.maybeRing(forTimeInSeconds: model.timeOfDayInSeconds)
            task.setTaskCompleted(success: true)
        }
    }
                                    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        clock.prepareForStart()
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.wbreeze.ShipsClock.updateMaybeRing", using: nil) {
            task in self.handleBackgroundUpdateMaybeRing(task: task as! BGAppRefreshTask)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        clock.prepareForShutdown()
    }


}

