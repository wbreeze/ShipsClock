//
  // ShipsClock
  // Created by Douglas Lovell on 20/8/21.
  // Copyright © 2021 Douglas Lovell
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
  

import Foundation

class ClockConfiguration : UserDefaults {
    let domainKey = "com.wbreeze.ShipsClock"
    let showLatLonKey = "ShowLatLon"
    let showDirectionKey = "ShowDirection"
    
    func reset() {
        removeObject(forKey: showLatLonKey)
        removeObject(forKey: showDirectionKey)
    }
    
    func showLatLon() -> Bool {
        return bool(forKey: showLatLonKey);
    }
    
    func showLatLon(_ doShow : Bool) {
        set(doShow, forKey: showLatLonKey)
    }

    func showDirection() -> Bool {
        return bool(forKey: showDirectionKey);
    }
    
    func showDirection(_ doShow : Bool) {
        set(doShow, forKey: showDirectionKey)
    }
}
