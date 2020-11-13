//
  // ShipsClockTests
  // Created by Douglas Lovell on 11/12/20.
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

class DelaunayTest: XCTestCase {
    let prec = 1.0

    struct TestCase {
        let description : String
        let julianDay : Double
        let expectedD, expectedF, expectedL, expectedLP : Double
    }
    
    /*
     These test values came from the ELPMPP02.for program extended to
     output Delaunay applied to julian day epoch 2000.
     */
    func testCases() -> [TestCase] {
        [
            TestCase(description: "17", julianDay: 1700000.5,
                     expectedD: -159899.97,
                     expectedF: -173526.807,
                     expectedL: -171370.128,
                     expectedLP: -12928.09),
            TestCase(description: "19", julianDay: 1900000.5,
                     expectedD: -117346.221,
                     expectedF: -127347.651,
                     expectedL: -125764.728,
                     expectedLP: -9487.696),
            TestCase(description: "21", julianDay: 2100000.5,
                     expectedD: -74792.475,
                     expectedF: -81168.498,
                     expectedL: -80159.319,
                     expectedLP: -6047.301),
            TestCase(description: "23", julianDay: 2300000.5,
                     expectedD: -32238.73,
                     expectedF: -34989.35,
                     expectedL: -34553.901,
                     expectedLP: -2606.907),
            TestCase(description: "25", julianDay: 2500000.5,
                     expectedD: 10315.013,
                     expectedF: 11189.795,
                     expectedL: 11051.525,
                     expectedLP: 833.487)
        ]
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        testCases().forEach { t in
            let epoch = 2451545.0
            let d = Delaunay(julianDay2000: t.julianDay - epoch)
            XCTAssertEqual(d.d, t.expectedD, accuracy: prec,
                           t.description + ":D")
            XCTAssertEqual(d.f, t.expectedF, accuracy: prec,
                           t.description + ":F")
            XCTAssertEqual(d.l, t.expectedL, accuracy: prec,
                           t.description + ":L")
            XCTAssertEqual(d.lp, t.expectedLP, accuracy: prec,
                           t.description + ":LP")
        }
    }

}

