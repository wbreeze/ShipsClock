  // ShipsClock
  // Created by Douglas Lovell on 6/6/20.
  // Copyright © 2020 Douglas Lovell
  /*
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this fileprivate except in compliance with the License.
   You may obtain a copy of the License at
   
   http://www.apache.org/licenses/LICENSE-2.0
   
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   */
  
  import Foundation
  
  /*
   Compute the sun position following Michalsky, Joseph. (1988). "The Astronomical Almanac's algorithm for approximate solar position (1950–2050)". Solar Energy. 40. 227-235. 10.1016/0038-092X(88)90045-X retrieved from https://www.researchgate.net/publication/222131147_The_Astronomical_Almanac%27s_algorithm_for_approximate_solar_position_1950-2050
   */
  struct SunCalculator {
    let epoch = 2451545.0 // calcs use base 2000-01-01 00:00 UT
    
    // Compute the right ascension of the sun at a given time.
    func rightAscension(julianDay jd: Double) -> Double {
        let time = jd - epoch
        // mnlong: mean longitude of the sun in degrees
        let mnlong = 280.460 + 0.9856474 * time
        // mnanom: mean anomoly for mnlong in normalized radians
        let mnanom = Arcs.radiansGiven(degrees: 357.528 + 0.9856003 * time)
        // eclong: ecliptic longitude in normalized radians
        let eclong = Arcs.radiansGiven(degrees: mnlong + 1.915 * sin(mnanom) + 0.020 * sin(2 * mnanom))
        // oblqec: obliquity of ecliptic in normalized radians
        let oblqec = Arcs.radiansGiven(degrees: 23.439 - 4.0e-7 * time)
        // ra: right ascension of the sun in normalized radians
        return atan2(cos(oblqec) * sin(eclong), cos(eclong))
    }

    /*
     Compute the hour angle of the sun in degrees relative
     to the given longitude at the given time.
     */
    func hourAngle(julianDay jd: Double, longitude lon: Double) -> Double {
        let ra = rightAscension(julianDay: jd)
        return Time.hourAngle(julianDay: jd, longitude: lon, rightAscension: ra)
    }
  }
