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
    static let twoPi = 2.0 * Double.pi

    // Normalize degrees to range 0.0 <= degrees < 360.0
    static func normalizedDegrees(for d: Double) -> Double {
        let pm = d.truncatingRemainder(dividingBy: 360.0)
        return 0.0 <= pm ? pm : pm + 360.0
    }

    // Normalize radians to range 0.0 <= radians < 2pi
    static func normalizedRadians(for r: Double) -> Double {
        let pm = r.truncatingRemainder(dividingBy: twoPi)
        return 0.0 <= pm ? pm : pm + twoPi
    }

    // Normalize hours to range 0.0 <= hours < 24.0
    static func normalizedHours(for h: Double) -> Double {
        let ph = h.truncatingRemainder(dividingBy: 24.0)
        return 0.0 <= ph ? ph : ph + 24.0
    }
    
    // Convert from degrees to radians normalized to range
    // 0.0 <= radians < 2.0 * Pi
    static func radiansGiven(degrees d: Double) -> Double {
        normalizedRadians(for: d * twoPi / 360.0)
    }
    
    // Convert from radians to degrees normalized to range
    // 0.0 <= degrees < 360.0
    static func degreesGiven(radians r: Double) -> Double {
        return normalizedDegrees(for: r * 360.0 / twoPi)
    }
    
    // Normalize radians to degrees longitude
    // Returns degrees longitude in range -180.0 < d <= 180.0
    static func longitudeGiven(radians r: Double) -> Double {
        let d = degreesGiven(radians: r)
        return 180.0 < d ? d - 360.0 : d
    }
    
    // Normalize degrees longitude
    // Returns degrees longitude in range -180.0 < d <= 180.0
    static func longitudeGiven(degrees d: Double) -> Double {
        let dr = d.truncatingRemainder(dividingBy: 360.0)
        let pm = dr <= -180.0 ? dr + 360.0 : dr
        return 180.0 < pm ? pm - 360.0 : pm
    }
    
    static func hmsToAngle(_ h: Int, _ m: Int, _ s: Int) -> Double {
        let sign = h < 0 || m < 0 || s < 0 ? -1.0 : 1.0
        return sign * (
                Double(abs(h)) * 15.0 +
                Double(abs(m)) * 15.0 / 60.0 +
                Double(abs(s)) * 15.0 / 3600.0
        )
    }
    
    static func dmsToAngle(_ d: Int, _ m: Int, _ s: Double) -> Double {
        let sign = d < 0 || m < 0 || s < 0.0 ? -1.0 : 1.0
        return sign * (
            Double(abs(d)) + Double(abs(m)) / 60.0 + abs(s) / 3600.0
        )
    }
    
    /*
     Print an angle expressed in degrees as hours and minutes
     */
    static func hms(_ label: String, _ degrees: Double) -> String {
        var hour = degrees / 15.0
        var dir = "West"
        if hour < 0.0 {
            dir = "East"
            hour = -hour
        }
        let timeInSeconds = Int(hour * 3600.0)
        let minutes = (timeInSeconds % 3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%@: %@ %dh %dm %ds (%lf)",
                      label, dir, Int(hour),
                      minutes, seconds, degrees)
    }
    
    /*
     Print an angle expressed in degrees as degrees, minutes, seconds
     */
    static func dms(_ label: String, _ degrees: Double) -> String {
        let arcSeconds = Int(degrees * 3600.0)
        let minutes = (arcSeconds % 3600) / 60
        let seconds = arcSeconds % 60
        return String(format: "%@: %dº %d' %d\" (%lf)",
                      label, Int(degrees), minutes, seconds,
                      degrees)
    }
    
    /*
     Given right ascension and declination of two directions on a sphere, in degrees
     Provide the angular distance between them on a great circle, in degrees.
     The angle is always the minor arc of the great circle, the lesser of the two, thus
     0 <= angularDistance <= 180.0
     */
    static func angularDistance(ra1: Double, decl1: Double, ra2: Double, decl2: Double) -> Double {
        let d2r = Double.pi / 180.0
        let phi1 = ra1 * d2r
        let phi2 = ra2 * d2r
        let theta1 = decl1 * d2r
        let theta2 = decl2 * d2r
        return acos(
            sin(theta1) * sin(theta2) +
            cos(theta1) * cos(theta2) * cos(phi1 - phi2)
        ) / d2r
    }
}
