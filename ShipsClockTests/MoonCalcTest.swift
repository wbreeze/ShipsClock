//
  // ShipsClockTests
  // Created by Douglas Lovell on 7/31/20.
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
  
import XCTest

class MoonCalcTest: XCTestCase {
    let jules = Julian()
    let calculator = MoonCalculator()
    
    struct LocationTestCase {
        let julianDay, observerLongitude: Double
        let rightAscension, hourAngle: Double
        let eclipticLongitude, eclipticLatitude: Double
        let description: String
    }
    
    func locationTests() -> [LocationTestCase] {
        let eastLocation = Arcs.dmsToAngle(-37, 39, 36.0)
        let westLocation = Arcs.dmsToAngle(-56, 10, 9.9)
        return [
            LocationTestCase(
                julianDay: jules.julianDay(2019, 10, 2, 20, 0, 0),
                observerLongitude: westLocation,
                rightAscension: Arcs.hmsToAngle(16, 12, 54),
                hourAngle: Arcs.hmsToAngle(0, 47, 24),
                eclipticLongitude: Arcs.dmsToAngle(244, 32, 22.9),
                eclipticLatitude: Arcs.dmsToAngle(3, 23, 33.3),
                description: "October 2, 2019"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 7, 31, 14, 0, 0),
                observerLongitude: eastLocation,
                rightAscension: Arcs.hmsToAngle(18, 6, 43),
                hourAngle: Arcs.hmsToAngle(-9, 58, 45),
                eclipticLongitude: Arcs.dmsToAngle(271, 32, 43.0),
                eclipticLatitude: Arcs.dmsToAngle(0, 32, 19.3),
                description: "July 31, 2020"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 8, 02, 16, 0, 0),
                observerLongitude: eastLocation,
                rightAscension: Arcs.hmsToAngle(20, 7, 51),
                hourAngle: Arcs.hmsToAngle(-9, 51, 41),
                eclipticLongitude: Arcs.dmsToAngle(299, 22, 7.2),
                eclipticLatitude: Arcs.dmsToAngle(-1, 57, 24.9),
                description: "August 2, 2020"),
            LocationTestCase(
                julianDay: jules.julianDay(2020,11, 1, 12, 0, 0),
                observerLongitude: westLocation,
                rightAscension: Arcs.hmsToAngle(3, 6, 55),
                hourAngle: Arcs.hmsToAngle(7, 53, 21),
                eclipticLongitude: Arcs.dmsToAngle(48, 34, 48.5),
                eclipticLatitude: Arcs.dmsToAngle(0, 0, 0),
                description: "November 1, 2020"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 11, 14, 9, 0, 0),
                observerLongitude: westLocation,
                rightAscension: Arcs.hmsToAngle(14, 40, 17),
                hourAngle: Arcs.hmsToAngle(-5, 49, 16),
                eclipticLongitude: Arcs.dmsToAngle(221, 11, 46.4),
                eclipticLatitude: Arcs.dmsToAngle(4, 7, 25.2),
                description: "Noon, November 14, 2020")
        ]
    }
    
    func testEcliptic() throws {
        let prec = 4.0
        locationTests().forEach { t in
            let loc = calculator.location(julianDay: t.julianDay)
            let sc = EclToEqu.spherical(x: loc.x, y: loc.y, z: loc.z)
            let lon = Arcs.normalizedDegrees(for: sc.azimuth)
            let lat = EclToEqu.inclinationToLatitude(sc.inclination)
            XCTAssertEqual(
                lon, t.eclipticLongitude, accuracy: prec,
                "Lon for \(t.description)")
            XCTAssertEqual(
                lat, t.eclipticLatitude, accuracy: prec,
                "Lat for \(t.description)")
        }
    }
    
    func testEquatorial() throws {
        let prec = 4.0
        locationTests().forEach { t in
            let loc = calculator.location(julianDay: t.julianDay)
            let sc = EclToEqu.spherical(x: loc.x, y: loc.y, z: loc.z)
            let lon = Arcs.normalizedDegrees(for: sc.azimuth)
            let lat = EclToEqu.inclinationToLatitude(sc.inclination)
            let s = EclToEqu.eclipticToEquatorial(longitude: lon, latitude: lat)
            XCTAssertEqual(
                s.rightAscension, t.rightAscension, accuracy: prec,
                "Right ascension for \(t.description)")
        }
    }
    
    func testHourAngle() throws {
        let prec = 4.0
        locationTests().forEach { t in
            let ha = calculator.hourAngle(
                julianDay: t.julianDay,
                longitude: t.observerLongitude)
            XCTAssertEqual(ha,
                           t.hourAngle,
                           accuracy: prec,
                           t.description)
        }
    }
    
    struct EclipticTestCase {
        var jd, x, y, z: Double
        func description() -> String {
            "jd: #{jd}"
        }
    }
    
    func eclipticTests() -> [EclipticTestCase] {
        [
            EclipticTestCase(jd: 2444239.5,
                        x: 43890.2824005, y:381188.7274523, z:-31633.3816524),
            EclipticTestCase(jd: 2446239.5,
                        x: -313664.5964499, y: 212007.2667385, z: 33744.7512039),
            EclipticTestCase(jd: 2448239.5,
                        x: -273220.0606714, y: -296859.7682229, z: -34604.3569962),
            EclipticTestCase(jd: 2450239.5,
                        x: 171613.1427993, y: -318097.3375025, z: 31293.5482404),
            EclipticTestCase(jd: 2452239.5,
                        x: 396530.0063512, y: 47487.9224886, z: -36085.3090343)
        ]
    }
    
    func testEclipticLocation() throws {
        let precp = 500.0
        eclipticTests().forEach { t in
            let xyz = calculator.location(julianDay: t.jd)
            XCTAssertEqual(xyz.x, t.x, accuracy: t.x / precp, "X of \(t.description())")
            XCTAssertEqual(xyz.y, t.y, accuracy: t.y / precp, "Y of \(t.description())")
            XCTAssertEqual(xyz.z, t.z, accuracy: t.z / precp, "Z of \(t.description())")
        }
    }
}
