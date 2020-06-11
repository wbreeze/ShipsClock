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

class SunCalcTest: XCTestCase {
    let calculator = SunCalculator()

    func testJulian() throws {
        struct JulianTestDay {
            var month, day, year, hour, minute: Int
            var julian: Double
        }
        let tests = [
            JulianTestDay(month:  1, day:  1, year:  2000, hour: 12, minute:  0, julian: 2451545.0),
            JulianTestDay(month:  1, day:  1, year:  1999, hour:  0, minute:  0, julian: 2451179.5),
            JulianTestDay(month:  1, day: 27, year:  1987, hour:  0, minute:  0, julian: 2446822.5),
            JulianTestDay(month:  6, day: 19, year:  1987, hour: 12, minute:  0, julian: 2446966.0),
            JulianTestDay(month:  1, day: 27, year:  1988, hour:  0, minute:  0, julian: 2447187.5),
            JulianTestDay(month:  6, day: 19, year:  1988, hour: 12, minute:  0, julian: 2447332.0),
            JulianTestDay(month:  1, day:  1, year:  1900, hour:  0, minute:  0, julian: 2415020.5),
            JulianTestDay(month:  1, day:  1, year:  1600, hour:  0, minute:  0, julian: 2305447.5),
            JulianTestDay(month: 12, day: 31, year:  1600, hour:  0, minute:  0, julian: 2305812.5),
            JulianTestDay(month:  4, day: 10, year:   837, hour:  7, minute: 12, julian: 2026871.8),
            JulianTestDay(month: 12, day: 31, year:  -123, hour:  0, minute:  0, julian: 1676494.5),
            JulianTestDay(month:  1, day:  1, year:  -122, hour:  0, minute:  0, julian: 2676497.5),
            JulianTestDay(month:  7, day: 12, year: -1000, hour: 12, minute:  0, julian: 1356001.0),
            JulianTestDay(month:  2, day: 29, year: -1000, hour:  0, minute:  0, julian: 1355866.5),
            JulianTestDay(month:  8, day: 17, year: -1001, hour: 21, minute: 36, julian: 1355671.4),
            JulianTestDay(month:  1, day:  1, year: -4712, hour: 12, minute:  0, julian:       0.0)
        ]
        let cal = Calendar(identifier: .gregorian)
        tests.forEach { testDate in
            let dc = DateComponents(
                calendar: cal,
                timeZone: TimeZone(secondsFromGMT: 0),
                era: nil,
                year: testDate.year,
                month: testDate.month,
                day: testDate.day,
                hour: testDate.hour,
                minute: testDate.minute
            )
            let date = cal.date(from: dc)
            XCTAssertEqual(testDate.julian, calculator.julianDay(for: date!))
        }
    }
}
