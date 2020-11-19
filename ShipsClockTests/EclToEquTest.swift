//
  // ShipsClockTests
  // Created by Douglas Lovell on 11/18/20.
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

class EclToEquTest: XCTestCase {
    
    struct SphericalTest {
        var x, y, z : Double
        var r, a, i : Double
        func value() -> (radius:Double, azimuth:Double, inclination:Double) {
            EclToEqu.spherical(x:x, y:y, z:z)
        }
        func description() -> String {
            "x: \(x), y: \(y), z: \(z)"
        }
    }
    func sphericalTests() -> [SphericalTest] {
        [
            SphericalTest(x: 3.0, y: 4.0, z: 5.0, r: 7.0711, a: 53.1301, i: 45.0),
            SphericalTest(x: 3.0, y: -4.0, z: 5.0, r: 7.0711, a: -53.1301, i: 45.0),
            SphericalTest(x: -3.0, y: 4.0, z: 5.0, r: 7.0711, a: 126.8698, i: 45.0),
            SphericalTest(x: -3.0, y: -4.0, z: 5.0, r: 7.0711, a: -126.8698, i: 45.0),
            SphericalTest(x: 3.0, y: 4.0, z: -5.0, r: 7.0711, a: 53.1301, i: 135.0),
            SphericalTest(x: 3.0, y: -4.0, z: -5.0, r: 7.0711, a: -53.1301, i: 135.0),
            SphericalTest(x: -3.0, y: 4.0, z: -5.0, r: 7.0711, a: 126.8698, i: 135.0),
            SphericalTest(x: -3.0, y: -4.0, z: -5.0, r: 7.0711, a: -126.8698, i: 135.0),
        ]
    }
    func testSpherical() throws {
        let prec = 1.0e-03
        sphericalTests().forEach { t in
            let v = t.value()
            XCTAssertEqual(v.radius, t.r, accuracy: prec, "Radius for \(t.description())")
            XCTAssertEqual(v.azimuth, t.a, accuracy: prec, "Azimuth for \(t.description())")
            XCTAssertEqual(v.inclination, t.i, accuracy: prec, "Inclination for \(t.description())")
        }
    }
    
    struct EclipticConversionTest {
        // azimuth and incliniation also known as
        // longitude and latitude
        var londec, latdec : Double
        
        // right ascension and declination
        var ra, decl : Double
        
        func value() -> (declination: Double, rightAscension: Double) {
            EclToEqu.eclipticToEquatorial(longitude: londec, latitude: latdec)
        }
        
        func description() -> String {
            "ecliptic longitude: \(londec), latitude: \(latdec)"
        }
    }
    func eclipticConversionTests() -> [EclipticConversionTest] {
        [
            EclipticConversionTest(
                londec: Arcs.dmsToAngle(222, 53, 32.1),
                latdec: Arcs.dmsToAngle(3, 47, 28.3),
                ra: Arcs.hmsToAngle(14, 46, 28),
                decl: Arcs.dmsToAngle(-12, 5, 24.9)
            ),
            EclipticConversionTest(
                londec: Arcs.dmsToAngle(322, 13, 16.3),
                latdec: Arcs.dmsToAngle(-4, 7, 40.2),
                ra: Arcs.hmsToAngle(21, 43, 57),
                decl: Arcs.dmsToAngle(-18, 0, 12.0)
            ),
            EclipticConversionTest(
                londec: Arcs.dmsToAngle(45, 39, 30.4),
                latdec: Arcs.dmsToAngle(-2, 30, 28.5),
                ra: Arcs.hmsToAngle(2, 55, 46),
                decl: Arcs.dmsToAngle(14, 7, 29.8)
            ),
            EclipticConversionTest(
                londec: Arcs.dmsToAngle(131, 36, 48.3),
                latdec: Arcs.dmsToAngle(4, 36, 48.3),
                ra: Arcs.hmsToAngle(9, 1, 47),
                decl: Arcs.dmsToAngle(21, 43, 40.5)
            ),
            EclipticConversionTest(
                londec: Arcs.dmsToAngle(231, 10, 41.9),
                latdec: Arcs.dmsToAngle(3, 0, 16.0),
                ra: Arcs.hmsToAngle(15, 18, 16),
                decl: Arcs.dmsToAngle(-15, 9, 3.5)
            ),
        ]
    }
    
    func testEclipticToEquatorial() throws {
        let prec = 0.1
        eclipticConversionTests().forEach({ t in
            let v = t.value()
            XCTAssertEqual(v.declination, t.decl, accuracy: prec, "Decl in \(t.description())")
            XCTAssertEqual(v.rightAscension, t.ra, accuracy: prec, "RA in \(t.description())")
        })
    }
}
