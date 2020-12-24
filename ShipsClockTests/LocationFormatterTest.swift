//
  // ShipsClockTests
  // Created by Douglas Lovell on 23/12/20.
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

class LocationFormatterTest: XCTestCase {

    func testVelocityInKnots() throws {
        let prec = 1.0e-02
        XCTAssertEqual(Double(LocationFormatter.velocityInKnots(1.0)), 1.94, accuracy: prec)
        XCTAssertEqual(Double(LocationFormatter.velocityInKnots(12.0)), 23.32, accuracy: prec)
        XCTAssertEqual(Double(LocationFormatter.velocityInKnots(10.25)), 19.92, accuracy: prec)
        XCTAssertEqual(Double(LocationFormatter.velocityInKnots(0.25)), 0.49, accuracy: prec)
    }

}
