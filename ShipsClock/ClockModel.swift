//
  // ShipsClock
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
  

import Foundation

/**
 Adds location to the time model, and the computation of sun and moon hour angle
 */
class ClockModel : TimeModel {
    @Published var celestialComputer: CelestialComputer
    @Published var location: LocationTracker
    
    init(locationTracker: LocationTracker) {
        location = locationTracker
        celestialComputer =  CelestialComputer(locationTracker: locationTracker)
        super.init()
    }
    
    override func updateClock() {
        super.updateClock()
        celestialComputer.maybeUpdateTheSky(timeOfDayInSeconds: timeOfDayInSeconds)
    }
}
