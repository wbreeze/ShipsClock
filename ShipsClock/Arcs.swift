//
  // ShipsClock
  // Created by Douglas Lovell on 7/9/20.
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

struct Arcs {
    // Normalize degrees to range 0.0 <= degrees < 360.0
    static func normalizedDegrees(for d: Double) -> Double {
        let pm = d.truncatingRemainder(dividingBy: 360.0)
        return 0.0 <= pm ? pm : pm + 360.0
    }
    
    // Normalize hours to range 0.0 <= hours < 24.0
    static func normalizedHours(for h: Double) -> Double {
        let ph = h.truncatingRemainder(dividingBy: 24.0)
        return 0.0 <= ph ? ph : ph + 24.0
    }
    
    // Convert from degrees to radians normalized to range
    // 0.0 <= radians < 2.0 * Pi
    static func radiansGiven(degrees d: Double) -> Double {
        normalizedDegrees(for: d) * (2 * Double.pi) / 360.0
    }
    
    // Convert from radians to degrees normalized to range
    // 0.0 <= degrees < 360.0
    static func degreesGiven(radians d: Double) -> Double {
        let twoPi = (2.0 * Double.pi)
        return normalizedDegrees(for: d.truncatingRemainder(dividingBy: twoPi) * 360.0 / twoPi)
    }
    
    /*
     Print an angle expressed in degrees as hours and minutes
     */
    static func hms(_ label: String, _ degrees: Double) {
        var hour = degrees * 24.0 / 360.0
        var dir = "West"
        if hour < 0.0 {
            dir = "East"
            hour = -hour
        }
        print(label, dir, Int(hour), "h",
              Int(hour.truncatingRemainder(dividingBy: 1.0) * 60.0), "m",
              Int(hour.truncatingRemainder(dividingBy: 60.0) * 60.0),
              "s",
              degrees)
    }
    
    /*
     Print an angle expressed in degrees as degrees and minutes
     */
    static func dms(_ label: String, _ degrees: Double) {
        print(label, Int(degrees), "º",
              Int(degrees.truncatingRemainder(dividingBy: 1.0) * 60.0),
              "'",
              Int(degrees.truncatingRemainder(dividingBy: 60.0) * 60.0),
              "\"", degrees)
    }
}
