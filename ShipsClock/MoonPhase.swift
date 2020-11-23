//
  // ShipsClock
  // Created by Douglas Lovell on 23/11/20.
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

struct MoonPhase {
    static func phaseIndex(sunHourAngle haSun: Double, moonHourAngle haMoon: Double) -> Int {
        return Int(Arcs.normalizedDegrees(for: haSun - haMoon + 22.5) / 45.0)
    }
    
    static func relativePhaseIndex(sunHourAngle haSun: Double, moonHourAngle haMoon: Double,
                                   observerLatitude obs: Double, moonDeclination decl: Double) -> Int {
        let phaseReverse = [0, 7, 6, 5, 4, 3, 2, 1]
        let phaseIndex = self.phaseIndex(sunHourAngle: haSun, moonHourAngle: haMoon)
        return decl < obs ? phaseIndex : phaseReverse[phaseIndex]
    }
}
