//
  // ShipsClock
  // Created by Douglas Lovell on 5/13/20.
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

class LocationTracker: NSObject, ObservableObject, CLLocationManagerDelegate {
    var manager = CLLocationManager()
    var isAuthorized = false
    @Published var isValidLocation = false
    @Published var latitude: CLLocationDegrees
    @Published var longitude: CLLocationDegrees
    @Published var velocity: CLLocationSpeed
    @Published var course: CLLocationDirection

    static let compassPoints = [" N ", "NNE", " NE", "ENE", " E ", "ESE", " SE", "SSE", " S ", "SSW", " SW", "WSW", " W ", "WNW", " NW", "NNW"]

    override init() {
        latitude = 0.0
        longitude = 0.0
        velocity = 0.0
        course = 0.0
    }
    
    static func degreesMinutesSeconds(degrees: CLLocationDegrees) -> (Int, Int, Int) {
        let mf = degrees.truncatingRemainder(dividingBy: 1.0) * 60.0
        let s = round(mf.truncatingRemainder(dividingBy: 1.0) * 60.0)
        return (Int(degrees), Int(mf), Int(s))
    }
    
    static func format(degrees latorlon: CLLocationDegrees, isLongitude isLon: Bool) -> String {
        var dForm: String
        if isLon {
            dForm = latorlon < 0 ? "W %03d" : "E %03d"
        } else {
            dForm = latorlon < 0 ? "S  %02d" : "N  %02d"
        }
        let (d, m, s) = degreesMinutesSeconds(degrees: abs(latorlon))
        return String(format: "\(dForm)º %02d' %02d\" (%08.4f)", locale: Locale.current, arguments: [d, m, s, abs(latorlon)])
    }
    
    func courseCompassPoint() -> String {
        let point = Int(course.advanced(by: 11.25).truncatingRemainder(dividingBy: 360.0) / 22.5)
        if (0 <= point && point < LocationTracker.compassPoints.count) {
            return LocationTracker.compassPoints[point]
        } else {
            return "\(course)?"
        }
    }
    
    // report velicity stored in m/s as knots, nautical miles per hour
    func velocityInKnots() -> Float {
        return (0.0 <= velocity) ? Float(velocity * 360.0 / 1852.0) : 0.0
    }
    
    func courseAndSpeed() -> String {
        if (0.0 <= course && 0.0 < velocity) {
            let ccp = courseCompassPoint()
            let ctrue = Int(round(course))
            let kts = velocityInKnots()
            return String.localizedStringWithFormat(
                "%03dº true, %@ at %.1f kts",
                ctrue, ccp, kts
            )
        } else {
            return("Not making way")
        }
    }
    
    func seekPermission() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
    }
    
    func activate() {
        if isAuthorized {
            manager.startUpdatingLocation()
            manager.startUpdatingHeading()
        }
    }
    
    func deactivate() {
        manager.stopUpdatingHeading()
        manager.stopUpdatingLocation()
        self.isValidLocation = false
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            isAuthorized = false
            deactivate()
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            isAuthorized = true
            activate()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error \(error)")
        isValidLocation = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current = locations.last {
            self.latitude = current.coordinate.latitude
            self.longitude = current.coordinate.longitude
            self.velocity = current.speed
            self.course = current.course
            self.isValidLocation = true
        }
    }
}
