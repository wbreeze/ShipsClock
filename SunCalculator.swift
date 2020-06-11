//
  // ShipsClock
  // Created by Douglas Lovell on 6/6/20.
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

/*
 Compute the sun position, following Michalsky, Joseph. (1988).
 "The Astronomical Almanac's algorithm for approximate solar position (1950–2050)".
 Solar Energy. 40. 227-235. 10.1016/0038-092X(88)90045-X retrieved from
 https://www.researchgate.net/publication/222131147_The_Astronomical_Almanac%27s_algorithm_for_approximate_solar_position_1950-2050
 */
struct SunCalculator {
    /*
     This is not the Julian Calendar, but rather a date and time concept
     developed by Josephus Justus Scaliger, whose father was named Julius.
     
     See https://en.wikipedia.org/wiki/Julian_day
     */
    func julianDay(for date: Date) -> Double {
        return 0.0
    }
}
