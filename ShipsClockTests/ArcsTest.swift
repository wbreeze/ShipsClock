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

class ArcsTest: XCTestCase {
    
    func testNormalizedDegrees() throws {
        let prec = 1.0e-03
        XCTAssertEqual(Arcs.normalizedDegrees(for: 0.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: 90.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: -90.0), 270.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: 180.0), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: -180.0), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: -270.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: 360.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: 720.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: -360.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: -720.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedDegrees(for: -900.0), 180.0, accuracy: prec)
    }

    func testNormalizedRadians() throws {
        let prec = Double.pi / 1_000.0
        let halfPi = Double.pi / 2.0
        let pi = Double.pi // shorthand
        
        XCTAssertEqual(Arcs.normalizedRadians(for: 0.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: halfPi), halfPi, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: -halfPi), pi + halfPi, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: pi), pi, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: -pi), pi, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: -pi - halfPi), halfPi, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: 2.0 * pi), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: 4.0 * pi), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: -2.0 * pi), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: -4.0 * pi), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedRadians(for: -5.0 * pi), pi, accuracy: prec)
    }
    
    func testNormalizedHours() throws {
        let prec = 1.0/360.0
        XCTAssertEqual(Arcs.normalizedHours(for: 0.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: 6.0), 6.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: -6.0), 18.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: 12.0), 12.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: -12.0), 12.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: -18.0), 6.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: 24.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: 48.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: -24.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: -48.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.normalizedHours(for: -60.0), 12.0, accuracy: prec)
    }
    
    func testRadiansGiven() throws {
        let prec = Double.pi / 1_000.0
        XCTAssertEqual(Arcs.radiansGiven(degrees: 0.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: 360.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: -360.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: 720.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: -900.0), Double.pi, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: 90.0), Double.pi / 2.0, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: -90.0), 3.0 * Double.pi / 2.0, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: 180.0), Double.pi, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: -180.0), Double.pi, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: 270.0), 3.0 * Double.pi / 2.0, accuracy: prec)
        XCTAssertEqual(Arcs.radiansGiven(degrees: -270.0), Double.pi / 2.0, accuracy: prec)
    }
    
    func testDegreesGiven() throws {
        let prec = 1.0e-03
        XCTAssertEqual(Arcs.degreesGiven(radians: 0.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.degreesGiven(radians: 2.0 * Double.pi), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.degreesGiven(radians: -2.0 * Double.pi), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.degreesGiven(radians: Double.pi / 2.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.degreesGiven(radians: -Double.pi / 2.0), 270.0, accuracy: prec)
        XCTAssertEqual(Arcs.degreesGiven(radians: Double.pi), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.degreesGiven(radians: -Double.pi), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.degreesGiven(radians: 3.0 * Double.pi / 2.0), 270.0, accuracy: prec)
        XCTAssertEqual(Arcs.degreesGiven(radians: -3.0 * Double.pi / 2.0), 90.0, accuracy: prec)
    }
}
