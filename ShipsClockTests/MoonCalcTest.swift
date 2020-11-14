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
    let prec = 1.0
    
    struct LongitudeTestCase {
        let julianDay: Double
        let azimuth, rightAscension, hourAngle: Double
        let eclipticLongitude, galacticLongitude: Double
        let description: String
    }
    
    func lonTests() -> [LongitudeTestCase] {
        [
            LongitudeTestCase(
                julianDay: 1700000.5,
                azimuth: Arcs.dmsToAngle(101, 38, 52.5),
                rightAscension: Arcs.hmsToAngle(18, 22, 40),
                hourAngle: Arcs.hmsToAngle(6, 40, 4),
                eclipticLongitude: -172829.58663,
                galacticLongitude: Arcs.dmsToAngle(7, 49, 49.6),
                description: "July 31, 2020"),
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
                description: "August 2, 2020")
        ]
    }
    
    func testLongitude() throws {
        lonTests().forEach { t in
            let lon = calculator.longitude(julianDay: t.julianDay)
            XCTAssertEqual(lon, t.eclipticLongitude, accuracy: prec, t.description)
        }
    }
}

