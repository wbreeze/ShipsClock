//
  // ShipsClock
  // Created by Douglas Lovell on 6/14/20.
  // Copyright © 2020 Douglas Lovell
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

class CelestialComputer : ObservableObject {
    var locationTracker: LocationTracker
    var lastCelestialCalc = 0
    var sunCalculator = SunCalculator()
    let jules = Julian()
    @Published var sunHourAngle: Double?
    
    init(locationTracker: LocationTracker) {
        self.locationTracker = locationTracker
    }
    
    func maybeUpdateTheSky(timeOfDayInSeconds: Int) {
        if locationTracker.isValidLocation {
            if sunHourAngle == nil ||
                60 < timeOfDayInSeconds - lastCelestialCalc
            {
                let jd = jules.julianDay(for: Date())
                let lon = locationTracker.longitude
                sunHourAngle = sunCalculator.hourAngle(julianDay: jd, longitude: lon)
                lastCelestialCalc = timeOfDayInSeconds
            }
        } else {
            sunHourAngle = nil
        }
    }
}
