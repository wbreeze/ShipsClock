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
    let prec = 1.0
    
    struct LongitudeTestCase {
        let julianDay, expectedLongitude: Double
    }
    
    func lonTests() -> [LongitudeTestCase] {
        [
            LongitudeTestCase(
            julianDay: jules.julianDay(2020, 7, 31, 16, 0, 0),
            expectedLongitude: Arcs.angle(0, 26, 15))
        ]
    }
    
    func testLongitude() throws {
        lonTests().forEach { t in
            let calculator = MoonCalculator(julianDay: t.julianDay)
            let lon = calculator.longitude()
            XCTAssertEqual(lon, t.expectedLongitude, accuracy: prec)
        }
    }
}
