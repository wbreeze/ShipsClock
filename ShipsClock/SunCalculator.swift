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
     
     This is essentially the same as the computation taught in Reda & Andreas, "Solar Position Algorithm for Solar Radiation Applications", NREL/TP-560-34302 retrieved as https://www.nrel.gov/docs/fy08osti/34302.pdf
         and in Michalsky (referenced in the class comment)
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

    // Normalize degrees to range 0.0 <= degrees < 360.0
    fileprivate func normalizedDegrees(for d: Double) -> Double {
        let pm = d.truncatingRemainder(dividingBy: 360.0)
        return 0.0 <= pm ? pm : pm + 360.0
    }
    
    // Normalize hours to range 0.0 <= hours < 24.0
    fileprivate func normalizedHours(for h: Double) -> Double {
        let ph = h.truncatingRemainder(dividingBy: 24.0)
        return 0.0 <= ph ? ph : ph + 24.0
    }
    
    // Convert from degrees to radians normalized to range
    // 0.0 <= radians < 2.0 * Pi
    fileprivate func radiansGiven(degrees d: Double) -> Double {
        normalizedDegrees(for: d) * (2 * Double.pi) / 360.0
    }
    
    // Convert from radians to degrees normalized to range
    // 0.0 <= degrees < 360.0
    fileprivate func degreesGiven(radians d: Double) -> Double {
        let twoPi = (2.0 * Double.pi)
        return normalizedDegrees(for: d.truncatingRemainder(dividingBy: twoPi) * 360.0 / twoPi)
    }
    
    /*
     Print an angle expressed in degrees as hours and minutes
     */
    func hms(_ label: String, _ degrees: Double) {
        var hour = degrees * 24.0 / 360.0
        var dir = "West"
        if hour < 0.0 {
            dir = "East"
            hour = -hour
        }
        print(label, dir, Int(hour), "h", Int(hour.truncatingRemainder(dividingBy: 1.0) * 60.0), "m", degrees)
    }
    
    /*
     Print an angle expressed in degrees as degrees and minutes
     */
    func dms(_ label: String, _ degrees: Double) {
        print(label, Int(degrees), "d", Int(degrees.truncatingRemainder(dividingBy: 1.0) * 60.0), "m", degrees)
    }
    
    /*
     Compute the hour angle of the sun in degrees relative
       to the given longitude at the given time.
     Zero is on the local meridian, at the given longitude,
       at the highest apparent azimuth (as near to overhead)
       as it will be for the day.
     The angle is normalized to -180.0 <= hourAngle <= 180.0
     */
    func hourAngle(julianDay jd: Double, longitude lon: Double) -> Double {
        let time = jd - 2451545.0 // calcs use base 2000-01-01 00:00 UT
        // mnlong: mean longitude of the sun in normalized degrees
        let mnlong = normalizedDegrees(for: 280.460 + 0.9856474 * time)
        // mnanom: mean anomoly for mnlong in normalized radians
        let mnanom = radiansGiven(degrees: 357.528 + 0.9856003 * time)
        // eclong: ecliptic longitude in normalized radians
        let eclong = radiansGiven(degrees: mnlong + 1.915 * sin(mnanom) + 0.020 * sin(2 * mnanom))
        // oblqec: obliquity of ecliptic in normalized radians
        let oblqec = radiansGiven(degrees: 23.439 - 0.0000004 * time)
        // ra: right ascension of the sun in normalized radians
        let ra = atan(cos(oblqec) * sin(eclong) / cos(eclong))
        // hour: hour portion of UT (jd has noon at zero, thus add 0.5)
        let hour = (jd.truncatingRemainder(dividingBy: 1.0) + 0.5) * 24.0
        // gmst: mean sidereal time in normalized hours UT
        let gmst = normalizedHours(for: 6.697375 + 0.0657098242 * time + hour)
        // lmst: local mean sidereal time in hours UT
        let lmst = normalizedHours(for: gmst + lon / 15.0)
        // lang: local hour angle in normalized radians
        let lang = radiansGiven(degrees: lmst * 15.0)

        // return the normalized, local hour angle in degrees
        var ha = lang - ra
        ha = Double.pi < ha ? ha - 2.0 * Double.pi : ha
        ha = ha < -Double.pi ? ha + 2.0 * Double.pi : ha
        return ha * 180.0 / Double.pi
    }
}
