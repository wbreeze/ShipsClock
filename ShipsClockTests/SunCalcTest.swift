// SunCalcTest
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

import XCTest

/*
 hour angle tests verified by comparison with angles reported by
 the app Sky Safari 6 Pro, version 6.7.2.4
 */
class SunCalcTest: XCTestCase {
    let calculator = SunCalculator()
    let jules = Julian()
    
    func testHourAngleWestPM() throws {
        let jd = jules.julianDay(2020, 6, 14, 18, 35, 0)
        let lon = -74.25
        let ha = calculator.hourAngle(julianDay: jd, longitude: lon)
        XCTAssertEqual(ha, 24.387, accuracy: 1.0/60.0)
    }
    
    func testHourAngleEastPM() throws {
        let jd = jules.julianDay(2020, 6, 14, 19, 25, 0)
        let lon = 37.66
        let ha = calculator.hourAngle(julianDay: jd, longitude: lon)
        XCTAssertEqual(ha, 148.795, accuracy: 1.0/60.0)
    }
    
    func testHourAngleWestAM() throws {
        let jd = jules.julianDay(2020, 6, 14, 11, 44, 0)
        let lon = -73.5
        let ha = calculator.hourAngle(julianDay: jd, longitude: lon)
        XCTAssertEqual(ha, -77.598, accuracy: 1.0/60.0)
    }
    
    func testHourAngleEastAM() throws {
        let jd = jules.julianDay(2020, 6, 14, 8, 4, 0)
        let lon = 37.66
        let ha = calculator.hourAngle(julianDay: jd, longitude: lon)
        XCTAssertEqual(ha, -21.43, accuracy: 1.0/60.0)
    }
    
    // ra 6h 0m 53s
    // ha 9h 43m 10s
    // 20 jun 2020 22:42 local
    func testHourAngle20Jun() throws {
        let jd = jules.julianDay(2020, 6, 21, 2, 42, 0)
        let lon = -74.25
        let ha = calculator.hourAngle(julianDay: jd, longitude: lon)
        XCTAssertEqual(ha, -90.7, accuracy: 1.0/60.0)
    }

    // ra 6h 4m 20s
    // ha 5h 38m 59s
    // 21 jun 2020 18:38 local
    func testHourAngle21Jun() throws {
        let jd = jules.julianDay(2020, 6, 21, 22, 38, 0)
        let lon = -74.25
        let ha = calculator.hourAngle(julianDay: jd, longitude: lon)
        XCTAssertEqual(ha, -75.6, accuracy: 1.0/60.0)
    }
}
