//
  // WatchClock WatchKit Extension
  // Created by Douglas Lovell on 4/9/22.
  // Copyright © 2022 Douglas Lovell
  /*
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
  */
  

import SwiftUI

@main
struct WatchClockApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let clockModel = WatchClock()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView().environmentObject(clockModel).onChange(of: scenePhase) { phase in
                    switch phase {
                    case .active:
                        // The app has become active.
                        print("State: active")
                        clockModel.moveToForeground()
                        break
                    case .inactive:
                        // The app has become inactive.
                        print("State: inactive")
                        break
                    case .background:
                        // The app has moved to the background.
                        print("State: background")
                        clockModel.moveToBackground()
                        break
                    @unknown default:
                        fatalError("WatchClock has entered an unknown state.")
                    }
                }
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
