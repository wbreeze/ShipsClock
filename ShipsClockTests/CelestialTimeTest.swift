//
// ShipsClockTests
// Created by Douglas Lovell on 11/19/20.
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

class CelestialTimeTest: XCTestCase {
    let jules = Julian()
    
    struct LocationTestCase {
        let julianDay, observerLongitude: Double
        let rightAscension, hourAngle: Double
        let description: String
    }
    
    func locationTests() -> [LocationTestCase] {
        let eastLocation = Arcs.dmsToAngle(-37, 39, 36.0)
        let westLocation = Arcs.dmsToAngle(-56, 10, 9.9)
        let westLon = -74.25
        let eastLon = 37.66

        return [
            LocationTestCase(
                julianDay: jules.julianDay(2019, 10, 2, 20, 0, 0),
                observerLongitude: westLocation,
                rightAscension: Arcs.hmsToAngle(16, 12, 54),
                hourAngle: Arcs.hmsToAngle(0, 47, 24),
                description: "October 2, 2019"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 7, 31, 14, 0, 0),
                observerLongitude: eastLocation,
                rightAscension: Arcs.hmsToAngle(18, 6, 43),
                hourAngle: Arcs.hmsToAngle(-9, 58, 45),
                description: "July 31, 2020"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 8, 02, 16, 0, 0),
                observerLongitude: eastLocation,
                rightAscension: Arcs.hmsToAngle(20, 7, 51),
                hourAngle: Arcs.hmsToAngle(-9, 51, 41),
                description: "August 2, 2020"),
            LocationTestCase(
                julianDay: jules.julianDay(2020,11, 1, 12, 0, 0),
                observerLongitude: westLocation,
                rightAscension: Arcs.hmsToAngle(3, 6, 55),
                hourAngle: Arcs.hmsToAngle(7, 53, 21),
                description: "November 1, 2020"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 11, 14, 9, 0, 0),
                observerLongitude: westLocation,
                rightAscension: Arcs.hmsToAngle(14, 40, 17),
                hourAngle: Arcs.hmsToAngle(-5, 49, 16),
                description: "Noon, November 14, 2020"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 6, 14, 18, 35, 0),
                observerLongitude: westLon,
                rightAscension: Arcs.hmsToAngle(5, 34, 31),
                hourAngle: Arcs.hmsToAngle(1, 37, 32),
                description: "WestPM"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 6, 14, 19, 25, 0),
                observerLongitude: eastLon,
                rightAscension: Arcs.hmsToAngle(5, 36, 3),
                hourAngle: Arcs.hmsToAngle(9, 55, 39),
                description: "EastPM"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 6, 14, 11, 44, 0),
                observerLongitude: westLon,
                rightAscension: Arcs.hmsToAngle(5, 33, 20),
                hourAngle: Arcs.hmsToAngle(-5, 13, 24),
                description: "WestAM"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 6, 14, 8, 4, 0),
                observerLongitude: eastLon,
                rightAscension: Arcs.hmsToAngle(5, 34, 4),
                hourAngle: Arcs.hmsToAngle(-1, 25, 43),
                description: "EastAM"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 6, 21, 2, 42, 0),
                observerLongitude: westLon,
                rightAscension: Arcs.hmsToAngle(6, 0, 53),
                hourAngle: Arcs.hmsToAngle(9, 43, 10),
                description: "20 June West PM"),
            LocationTestCase(
                julianDay: jules.julianDay(2020, 6, 22, 2, 42, 0),
                observerLongitude: westLon,
                rightAscension: Arcs.hmsToAngle(6, 5, 3),
                hourAngle: Arcs.hmsToAngle(9, 42, 57),
                description: "21 June West PM"),
        ]
    }
    
    func testHourAngle() throws {
        let prec = 0.5
        locationTests().forEach { t in
            let ha = CelestialTime.hourAngle(julianDay: t.julianDay, longitude: t.observerLongitude, rightAscension: t.rightAscension)
            XCTAssertEqual(
                ha, t.hourAngle, accuracy: prec,
                "Hour angle for \(t.description)")
        }
    }
}
