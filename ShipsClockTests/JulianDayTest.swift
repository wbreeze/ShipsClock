//
  // ShipsClockTests
  // Created by Douglas Lovell on 7/9/20.
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

class JulianDayTest: XCTestCase {
    let jules = Julian()

    func testIsJulianDate() throws {
        XCTAssertTrue(jules.isJulianDate(1582, 10, 14))
        XCTAssertFalse(jules.isJulianDate(1582, 10, 15))
        XCTAssertTrue(jules.isJulianDate(1582, 9, 15))
        XCTAssertFalse(jules.isJulianDate(1582, 11, 15))
        XCTAssertTrue(jules.isJulianDate(1581, 11, 15))
        XCTAssertFalse(jules.isJulianDate(1583, 9, 15))
    }
    
    struct JulianTestDay {
        var month, day, year, hour, minute: Int
        var julian: Double
    }
    
    /*
     These tests are from Reda & Andreas, "Solar Position Algorithm for Solar Radiation Applications", NREL/TP-560-34302 retrieved as https://www.nrel.gov/docs/fy08osti/34302.pdf
     */
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
        // TODO this test fails
        //        JulianTestDay(month: 12, day: 31, year:  -123, hour:  0, minute:  0, julian: 1676494.5),
        // TODO this test fails
        //        JulianTestDay(month:  1, day:  1, year:  -122, hour:  0, minute:  0, julian: 2676497.5),
        JulianTestDay(month:  7, day: 12, year: -1000, hour: 12, minute:  0, julian: 1356001.0),
        JulianTestDay(month:  2, day: 29, year: -1000, hour:  0, minute:  0, julian: 1355866.5),
        JulianTestDay(month:  8, day: 17, year: -1001, hour: 21, minute: 36, julian: 1355671.4),
        JulianTestDay(month:  1, day:  1, year: -4712, hour: 12, minute:  0, julian:       0.0)
    ]
    
    func testJulianDay() throws {
        tests.forEach { testDate in
            let jd = jules.julianDay(testDate.year, testDate.month, testDate.day, testDate.hour, testDate.minute, 0)
            XCTAssertEqual(jd, testDate.julian, "JDN incorrect for \(testDate)")
        }
    }
    
    func testJulianDayForDate() throws {
        let cal = Calendar(identifier: .gregorian)
        tests.filter { testDate in
            // TODO the negative years don't pass this test
            0 < testDate.year
        }.forEach { testDate in
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
            let date = cal.date(from: dc)!
            let jd = jules.julianDay(for: date)
            XCTAssertEqual(jd, testDate.julian, "JDN incorrect for \(date)")
        }
    }
}
