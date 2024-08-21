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
    var failCount = 0
    let MAX_FAIL = 3
    @Published var isValidLocation = false
    @Published var latitude: CLLocationDegrees
    @Published var longitude: CLLocationDegrees
    @Published var velocity: CLLocationSpeed
    @Published var course: CLLocationDirection

    override init() {
        latitude = 0.0
        longitude = 0.0
        velocity = 0.0
        course = 0.0
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
        if failCount == MAX_FAIL {
            self.isValidLocation = false
        }
        failCount += 1;
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current = locations.last {
            self.latitude = current.coordinate.latitude
            self.longitude = current.coordinate.longitude
            self.velocity = current.speed
            self.course = current.course
            self.isValidLocation = true
            self.failCount = 0
        }
    }
}
