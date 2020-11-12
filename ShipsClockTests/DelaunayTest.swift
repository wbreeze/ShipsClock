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
    
    func testCases() -> [TestCase] {
        [
            TestCase(description: "17", julianDay: 1700000.5,
                     expectedD: -65102318729347.000,
                     expectedF: -9392305918095.756,
                     expectedL: -394417025999805.688,
                     expectedLP: -17368133160466.908),
            TestCase(description: "19", julianDay: 1900000.5,
                     expectedD:      -18888239804537.637,
                     expectedF:       -2727013282919.186,
                     expectedL:     -114422659629843.391,
                     expectedLP:       -5038218972841.402),
            TestCase(description: "21", julianDay: 2100000.5,
                     expectedD:       -3119901613595.727,
                     expectedF:        -452193947885.301,
                     expectedL:      -18890849545993.520,
                     expectedLP:        -831699978916.090),
            TestCase(description: "23", julianDay: 2300000.5,
                     expectedD:        -108886327503.672,
                     expectedF:         -16782075763.288,
                     expectedL:        -654020122585.479,
                     expectedLP:         -28810296140.154),
            TestCase(description: "25", julianDay: 2500000.5,
                     expectedD:           -744642462.153,
                     expectedF:            245657653.072,
                     expectedL:          -6381280981.643,
                     expectedLP:           -269606831.508)
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
