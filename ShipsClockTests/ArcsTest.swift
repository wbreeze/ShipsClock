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
    
    func testLongitudeGivenRadians() throws {
        let prec = 1.0e-03
        XCTAssertEqual(Arcs.longitudeGiven(radians: 0.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(radians: 2.0 * Double.pi), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(radians: -2.0 * Double.pi), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(radians: Double.pi / 2.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(radians: -Double.pi / 2.0), -90.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(radians: Double.pi), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(radians: -Double.pi), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(radians: 3.0 * Double.pi / 2.0), -90.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(radians: -3.0 * Double.pi / 2.0), 90.0, accuracy: prec)
    }
    
    func testLongitudeGivenDegrees() throws {
        let prec = 1.0e-03
        XCTAssertEqual(Arcs.longitudeGiven(degrees: 0.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(degrees: 360.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(degrees: -360.0), 0.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(degrees: 90.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(degrees: -90.0), -90.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(degrees: 180.0), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(degrees: -180.0), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(degrees: 270.0), -90.0, accuracy: prec)
        XCTAssertEqual(Arcs.longitudeGiven(degrees: -270.0), 90.0, accuracy: prec)
    }
    
    func testHmsToAngle() throws {
        let prec = 1.0e-04
        XCTAssertEqual(Arcs.hmsToAngle(3, 0, 0), 45.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(6, 0, 0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(12, 0, 0), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(18, 0, 0), 270.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(24, 0, 0), 360.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-3, 0, 0), -45.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-6, 0, 0), -90.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-12, 0, 0), -180.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-18, 0, 0), -270.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-24, 0, 0), -360.0, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(3, 30, 0), 52.5, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(6, 30, 30), 97.625, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(12, 45, 0), 191.25, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(18, 45, 15), 281.3125, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(23, 15, 0), 348.75, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-3, 30, 0), -52.5, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-6, 30, 30), -97.625, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-12, 45, 0), -191.25, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-18, 45, 15), -281.3125, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(-23, 15, 0), -348.75, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, 30, 0), 7.5, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, 30, 30), 7.625, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, 45, 0), 11.25, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, 45, 15), 11.3125, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, 15, 0), 3.75, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, 0, 30), 0.125, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, -30, 0), -7.5, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, -30, 30), -7.625, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, -45, 0), -11.25, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, -45, 15), -11.3125, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, -15, 0), -3.75, accuracy: prec)
        XCTAssertEqual(Arcs.hmsToAngle(0, 0, -30), -0.125, accuracy: prec)
    }
    
    func testDmsToAngle() throws {
        let prec = 1.0e-05
        XCTAssertEqual(Arcs.dmsToAngle(45, 0, 0), 45.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(90, 0, 0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(180, 0, 0), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(270, 0, 0), 270.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(360, 0, 0), 360.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-45, 0, 0), -45.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-90, 0, 0), -90.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-180, 0, 0), -180.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-270, 0, 0), -270.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-360, 0, 0), -360.0, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(45, 30, 0), 45.5, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(90, 30, 30), 90.50833, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(180, 45, 0), 180.75, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(270, 45, 15), 270.75416, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(345, 15, 0), 345.25, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-45, 30, 0), -45.5, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-90, 30, 30), -90.50833, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-180, 45, 0), -180.75, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-270, 45, 15), -270.75416, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(-345, 15, 0), -345.25, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, 30, 0), 0.5, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, 30, 30), 0.50833, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, 45, 0), 0.75, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, 45, 15), 0.75416, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, 15, 0), 0.25, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, 0, 30), 0.00833, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, -30, 0), -0.5, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, -30, 30), -0.50833, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, -45, 0), -0.75, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, -45, 15), -0.75416, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, -15, 0), -0.25, accuracy: prec)
        XCTAssertEqual(Arcs.dmsToAngle(0, 0, -30), -0.00833, accuracy: prec)
    }
    
    func testAngularDistance() throws {
        let prec = 1.0e-02
        XCTAssertEqual(Arcs.angularDistance(ra1: 0.0, decl1: 0.0, ra2: 90.0, decl2: 90.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.angularDistance(ra1: 90.0, decl1: 0.0, ra2: 0.0, decl2: 0.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.angularDistance(ra1: 0.0, decl1: 0.0, ra2: 180.0, decl2: 90.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.angularDistance(ra1: 0.0, decl1: 0.0, ra2: 265.0, decl2: 90.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.angularDistance(ra1: 0.0, decl1: 45.0, ra2: 45.0, decl2: 45.0), 31.39, accuracy: prec)
        XCTAssertEqual(Arcs.angularDistance(ra1: 45.0, decl1: 0.0, ra2: 90.0, decl2: 0.0), 45.0, accuracy: prec)
        XCTAssertEqual(Arcs.angularDistance(ra1: 45.0, decl1: 0.0, ra2: 225.0, decl2: 0.0), 180.0, accuracy: prec)
        XCTAssertEqual(Arcs.angularDistance(ra1: -90.0, decl1: 45.0, ra2: 90.0, decl2: 45.0), 90.0, accuracy: prec)
        XCTAssertEqual(Arcs.angularDistance(ra1: -90.0, decl1: 0.0, ra2: 90.0, decl2: 0.0), 180.0, accuracy: prec)
    }
}
