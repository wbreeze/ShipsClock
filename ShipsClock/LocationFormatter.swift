//
  // ShipsClock
  // Created by Douglas Lovell on 12/23/20.
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
import CoreLocation

struct LocationFormatter {

    static let compassPoints = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]

    static func degreesMinutesSeconds(degrees: CLLocationDegrees) -> (Int, Int, Int) {
        let mf = degrees.truncatingRemainder(dividingBy: 1.0) * 60.0
        let s = round(mf.truncatingRemainder(dividingBy: 1.0) * 60.0)
        return (Int(degrees), Int(mf), Int(s))
    }
    
    static func formatDMS(degrees latorlon: CLLocationDegrees, isLongitude isLon: Bool) -> String {
        var dForm: String
        if isLon {
            dForm = latorlon < 0 ? "W %03d" : "E %03d"
        } else {
            dForm = latorlon < 0 ? "S  %02d" : "N  %02d"
        }
        let (d, m, s) = degreesMinutesSeconds(degrees: abs(latorlon))
        return String(format: "\(dForm)º %02d' %02d\"", locale: Locale.current, arguments: [d, m, s])
    }
    
    static func courseCompassPoint(_ course: CLLocationDegrees) -> String {
        let point = Int(course.advanced(by: 11.25).truncatingRemainder(dividingBy: 360.0) / 22.5)
        if (0 <= point && point < LocationFormatter.compassPoints.count) {
            return LocationFormatter.compassPoints[point]
        } else {
            return "\(course)?"
        }
    }
    
    // report velicity stored in m/s as knots, nautical miles per hour
    static func velocityInKnots(_ vms: CLLocationSpeed) -> Float {
        return (0.0 <= vms) ? Float(vms * 3600.0 / 1852.0) : 0.0
    }
    
    static func formatCourseAndSpeed(_ course: CLLocationDirection, _ velocity: CLLocationSpeed) -> String {
        if (0.0 <= course && 0.0 < velocity) {
            let ccp = courseCompassPoint(course)
            let kts = velocityInKnots(velocity)
            return String.localizedStringWithFormat(
                "%.1f kts %@",
                kts, ccp
            )
        } else {
            return("No way on")
        }
    }
}
