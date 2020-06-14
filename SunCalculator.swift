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
    
    func isJulianDate(_ year: Int, _ month: Int, _ day: Int) -> Bool
    {
        year < 1582 || (year == 1582 && (month < 10 || (month == 10 && day <= 14)))
    }

    /*
     This is not the Julian Calendar, but rather a date and time concept
     developed by Josephus Justus Scaliger, whose father was named Julius.
     
     See https://squarewidget.com/julian-day/ which implements the
     algorithm taught in _Astronomical Algorithms_ by Jean Meeus
     */
    func julianDay(_ y: Int, _ m: Int, _ d: Int, _ h: Int, _ i: Int, _ s: Int) -> Double {

        var ya = y
        var ma = m
        if m == 1 || m == 2 {
            ya = y - 1
            ma = m + 12
        }
        let a = ya / 100
        let b = isJulianDate(ya, ma, d) ? 0 : 2 - a + a / 4
        
        let yd = 1461 * (ya + 4716) / 4  // days in a year
        let md = Int(30.6001 * Double(ma + 1)) // average days in a month
        let t = Double(h) / 24.0 + Double(i) / 1440.0 + Double(s) / 8640.0
        
        return Double(yd + md + d + b) - 1524.5 + t
    }
    
    func julianDay(for date: Date) -> Double {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.init(secondsFromGMT: 0)!
        let parts = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        var jd = 0.0
        if let y = parts.year,
            let m = parts.month,
            let d = parts.day,
            let h = parts.hour,
            let i = parts.minute,
            let s = parts.second
        {
            jd = julianDay(y, m, d, h, i, s)
        }
        return jd
    }
}
