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
    
    struct LongitudeTestCase {
        let julianDay: Double
        let azimuth, rightAscension, hourAngle: Double
        let eclipticLongitude, galacticLongitude: Double
        let description: String
    }
    
    func lonTests() -> [LongitudeTestCase] {
        [
            LongitudeTestCase(
                julianDay: jules.julianDay(2019, 10, 2, 12, 0, 0),
                azimuth: Arcs.dmsToAngle(111, 42, 10.9),
                rightAscension: Arcs.hmsToAngle(15, 58, 12),
                hourAngle: Arcs.hmsToAngle(6, 59, 12),
                eclipticLongitude: Arcs.dmsToAngle(240, 47, 47.0),
                galacticLongitude: Arcs.dmsToAngle(354, 36, 47.8),
                description: "October 2, 2019"),
            LongitudeTestCase(
                julianDay: jules.julianDay(2020, 7, 31, 16, 0, 0),
                azimuth: Arcs.dmsToAngle(101, 38, 52.5),
                rightAscension: Arcs.hmsToAngle(18, 22, 40),
                hourAngle: Arcs.hmsToAngle(6, 40, 4),
                eclipticLongitude: Arcs.dmsToAngle(275, 9, 27.0),
                galacticLongitude: Arcs.dmsToAngle(7, 49, 49.6),
                description: "July 31, 2020"),
            LongitudeTestCase(
                julianDay: jules.julianDay(2020, 8, 02, 16, 0, 0),
                azimuth: Arcs.dmsToAngle(81, 49, 2.5),
                rightAscension: Arcs.hmsToAngle(20, 17, 46),
                hourAngle: Arcs.hmsToAngle(08, 27, 17),
                eclipticLongitude: Arcs.dmsToAngle(301, 24, 34.8),
                galacticLongitude: Arcs.dmsToAngle(19, 56, 23.9),
                description: "August 2, 2020"),
            LongitudeTestCase(
                julianDay: jules.julianDay(2020,11, 1, 12, 0, 0),
                azimuth: Arcs.dmsToAngle(266, 55, 51.1),
                rightAscension: Arcs.hmsToAngle(3, 6, 55),
                hourAngle: Arcs.hmsToAngle(7, 53, 21),
                eclipticLongitude: Arcs.dmsToAngle(48, 34, 48.5),
                galacticLongitude: Arcs.dmsToAngle(164, 34, 20.9),
                description: "November 1, 2020"),
            LongitudeTestCase(
                julianDay: jules.julianDay(2020,11, 14, 12, 0, 0),
                azimuth: Arcs.dmsToAngle(71, 00, 37.6),
                rightAscension: Arcs.hmsToAngle(14, 46, 23),
                hourAngle: Arcs.hmsToAngle(2, 54, 57),
                eclipticLongitude: Arcs.dmsToAngle(222, 53, 32.5),
                galacticLongitude: Arcs.dmsToAngle(341, 52, 23.4),
                description: "November 14, 2020")
        ]
    }
    
    func testLongitude() throws {
        let prec = 4.0
        lonTests().forEach { t in
            let loc = calculator.location(julianDay: t.julianDay)
            let sc = Arcs.spherical(x: loc.x, y: loc.y, z: loc.z)
            XCTAssertEqual(sc.azimuth, t.eclipticLongitude, accuracy: prec, t.description)
        }
    }
    
    struct XyzTestCase {
        var jd, x, y, z: Double
        func description() -> String {
            "jd: #{jd}"
        }
    }
    
    func xyzTests() -> [XyzTestCase] {
        [
            XyzTestCase(jd: 2444239.5,
                        x: 43890.2824005, y:381188.7274523, z:-31633.3816524),
            XyzTestCase(jd: 2446239.5,
                        x: -313664.5964499, y: 212007.2667385, z: 33744.7512039),
            XyzTestCase(jd: 2448239.5,
                        x: -273220.0606714, y: -296859.7682229, z: -34604.3569962),
            XyzTestCase(jd: 2450239.5,
                        x: 171613.1427993, y: -318097.3375025, z: 31293.5482404),
            XyzTestCase(jd: 2452239.5,
                        x: 396530.0063512, y: 47487.9224886, z: -36085.3090343)
        ]
    }
    
    func testXYZ() throws {
        let precp = 500.0
        xyzTests().forEach { t in
            let xyz = calculator.location(julianDay: t.jd)
            XCTAssertEqual(xyz.x, t.x, accuracy: t.x / precp, "X of \(t.description())")
            XCTAssertEqual(xyz.y, t.y, accuracy: t.y / precp, "Y of \(t.description())")
            XCTAssertEqual(xyz.z, t.z, accuracy: t.z / precp, "Z of \(t.description())")
        }
    }
}

