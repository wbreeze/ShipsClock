//
  // ShipsClock
  // Created by Douglas Lovell on 11/15/20.
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

struct CelestialTime {
    static let epoch = 2451545.0 // calcs use base 2000-01-01 00:00 UT
    
    // Compute local mean sidereal time in hours UT
    static func localMeanSiderialTime(
        julianDay jd: Double, longitude lon: Double
    ) -> Double {
        let time = jd - epoch
        // hour: hour portion of UT (jd has noon at zero, thus add 0.5)
        let hour = (jd + 0.5).truncatingRemainder(dividingBy: 1.0) * 24.0
        // gmst: mean sidereal time in normalized hours UT
        let gmst = 6.697375 + 0.0657098242 * time + hour
        return Arcs.normalizedHours(for: gmst + lon / 15.0)
    }
    
    /*
     Compute hour angle in degrees given time, longitude, right ascension
     
     time is Julian Day
     longitude is degrees
     right ascension is degrees
     
     Zero is on the local meridian, at the given longitude,
     at the highest apparent azimuth (as near to overhead)
     as it will be for the day.
     
     The angle is normalized to -180.0 <= hourAngle <= 180.0
     relative to the local meridian. Note that this means that
     angles to the east are negative, angles to the west are positive.
     That is opposite of the convention used for longitude.
     */
    static func hourAngle(
        julianDay jd: Double, longitude lon: Double, rightAscension ra: Double
    ) -> Double {
        let lmst = localMeanSiderialTime(julianDay: jd, longitude: lon)
        
        // lang: local mean siderial time in degrees
        let lang = lmst * 15.0
        
        // normalize the local hour angle in degrees
        var ha = lang - ra
        while (ha < -180.0) {
            ha += 360.0
        }
        while (180.0 < ha) {
            ha -= 360.0
        }
        return ha
    }
}
