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
    let prec = 0.125  // +- an eighth of a degree, half a minute
    
    struct TestCase {
        static let westLon = -74.25
        static let eastLon = 37.66
        let description : String
        let julianDay, longitude : Double
        let expectedRa, expectedHa : Double
    }
    
    func hour(_ h: Int, _ m: Int, _ s: Int) -> Double {
        return Double(h) + Double(m) / 60.0 + Double(s) / 3600.0
    }
    
    func testCases() -> [TestCase] {
        [
            TestCase(
                description: "WestPM",
                julianDay: jules.julianDay(2020, 6, 14, 18, 35, 0),
                longitude: TestCase.westLon,
                expectedRa: Arcs.angle(5, 34, 31),
                expectedHa: Arcs.angle(1, 37, 32)),
            TestCase(
                description: "EastPM",
                julianDay: jules.julianDay(2020, 6, 14, 19, 25, 0),
                longitude: TestCase.eastLon,
                expectedRa: Arcs.angle(5, 36, 3),
                expectedHa: Arcs.angle(9, 55, 39)),
            TestCase(
                description: "WestAM",
                julianDay: jules.julianDay(2020, 6, 14, 11, 44, 0),
                longitude: TestCase.westLon,
                expectedRa: Arcs.angle(5, 33, 20),
                expectedHa: -Arcs.angle(5, 13, 24)),
            TestCase(
                description: "EastAM",
                julianDay: jules.julianDay(2020, 6, 14, 8, 4, 0),
                longitude: TestCase.eastLon,
                expectedRa: Arcs.angle(5, 34, 4),
                expectedHa: -Arcs.angle(1, 25, 43)),
            TestCase(
                description: "20 June West PM",
                julianDay: jules.julianDay(2020, 6, 21, 2, 42, 0),
                longitude: TestCase.westLon,
                expectedRa: Arcs.angle(6, 0, 53),
                expectedHa: Arcs.angle(9, 43, 10)),
            TestCase(
                description: "21 June West PM",
                julianDay: jules.julianDay(2020, 6, 22, 2, 42, 0),
                longitude: TestCase.westLon,
                expectedRa: Arcs.angle(6, 5, 3),
                expectedHa: Arcs.angle(9, 42, 57)),
        ]
    }
    
    func testRightAscension() throws {
        let d2r = Double.pi / 180.0
        testCases().forEach { t in
            let ra = calculator.rightAscension(julianDay: t.julianDay)
            XCTAssertEqual(ra, t.expectedRa * d2r, accuracy: prec,
                           t.description)
        }
    }
    
    func testHourAngle() throws {
        testCases().forEach { t in
            let ha = calculator.hourAngle(
                julianDay: t.julianDay, longitude: t.longitude)
            XCTAssertEqual(ha, t.expectedHa, accuracy: prec,
                           t.description)
        }
    }
}
