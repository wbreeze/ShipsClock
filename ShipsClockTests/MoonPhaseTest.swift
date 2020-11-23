//
  // ShipsClockTests
  // Created by Douglas Lovell on 23/11/20.
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

class MoonPhaseTest: XCTestCase {
    // hour angles are degrees -180.0 <= ha <= 180.0, see CelestialTime.hourAngle
    let noon = 0.0
    let midnight = -180.0
    let midMorning = -90.0
    let midAfternoon = 90.0
    let lateNight = 180.0
    let midPhase = 22.0
    let phaseWidth = 45.0
    
    func testIndexSunLessThan() throws {
        let moonBase = midnight + midPhase
        var moonHa = Arcs.longitudeGiven(degrees: moonBase)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: midnight, moonHourAngle: moonHa), 0)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 1.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: midnight, moonHourAngle: moonHa), 7)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 2.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: midnight, moonHourAngle: moonHa), 6)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 3.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: midnight, moonHourAngle: moonHa), 5)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 4.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: midnight, moonHourAngle: moonHa), 4)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 5.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: midnight, moonHourAngle: moonHa), 3)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 6.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: midnight, moonHourAngle: moonHa), 2)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 7.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: midnight, moonHourAngle: moonHa), 1)
    }
    
    func testIndexSunGreaterThan() throws {
        let moonBase = midnight + midPhase
        var moonHa = Arcs.longitudeGiven(degrees: moonBase)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: lateNight, moonHourAngle: moonHa), 0)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: lateNight, moonHourAngle: moonHa), 7)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 2.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: lateNight, moonHourAngle: moonHa), 6)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 3.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: lateNight, moonHourAngle: moonHa), 5)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 4.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: lateNight, moonHourAngle: moonHa), 4)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 5.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: lateNight, moonHourAngle: moonHa), 3)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 6.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: lateNight, moonHourAngle: moonHa), 2)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 7.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: lateNight, moonHourAngle: moonHa), 1)
    }
    
    func testIndexNew() throws {
        for phase in 0...7 {
            let newMoon = 0
            let sunLocation = Arcs.longitudeGiven(degrees: Double(phase) * phaseWidth)
            XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: sunLocation,
                                                moonHourAngle: sunLocation + midPhase), newMoon)
            XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: sunLocation,
                                                moonHourAngle: sunLocation - midPhase), newMoon)
        }
    }
    
    func testIndexFull() throws {
        for phase in 0...7 {
            let fullMoon = 4
            let sunLocation = Arcs.longitudeGiven(degrees: Double(phase) * phaseWidth)
            let oppositeSun = Arcs.longitudeGiven(degrees: sunLocation + 180.0)
            XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: sunLocation,
                                                moonHourAngle: oppositeSun + midPhase), fullMoon)
            XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: sunLocation,
                                                moonHourAngle: oppositeSun - midPhase), fullMoon)
        }
    }

    func testIndexWaxing() throws {
        for phase in 0...7 {
            let waxingMoon = 6
            let sunLocation = Arcs.longitudeGiven(degrees: Double(phase) * phaseWidth)
            let approachingSun = Arcs.longitudeGiven(degrees: sunLocation + 90.0)
            XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: sunLocation,
                                                moonHourAngle: approachingSun + midPhase), waxingMoon)
            XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: sunLocation,
                                                moonHourAngle: approachingSun - midPhase), waxingMoon)
        }
    }

    func testIndexWaning() throws {
        for phase in 0...7 {
            let waningMoon = 2
            let sunLocation = Arcs.longitudeGiven(degrees: Double(phase) * phaseWidth)
            let leavingSun = Arcs.longitudeGiven(degrees: sunLocation - 90.0)
            XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: sunLocation,
                                                moonHourAngle: leavingSun + midPhase), waningMoon)
            XCTAssertEqual(MoonPhase.phaseIndex(sunHourAngle: sunLocation,
                                                moonHourAngle: leavingSun - midPhase), waningMoon)
        }
    }

    func testRelativeIndexNorth() throws {
        let moonBase = midnight + midPhase
        let observerLat = 45.0
        let moonDecl = 0.0
        var moonHa = Arcs.longitudeGiven(degrees: moonBase)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       0)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 1.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       7)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 2.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       6)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 3.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       5)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 4.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       4)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 5.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       3)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 6.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       2)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 7.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       1)
    }
    
    func testRelativeIndexSouth() throws {
        let moonBase = midnight + midPhase
        let observerLat = -45.0
        let moonDecl = 0.0
        var moonHa = Arcs.longitudeGiven(degrees: moonBase)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       0)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 1.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       1)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 2.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       2)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 3.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       3)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 4.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       4)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 5.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       5)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 6.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       6)
        moonHa = Arcs.longitudeGiven(degrees: moonBase + 7.0 * phaseWidth)
        XCTAssertEqual(MoonPhase.relativePhaseIndex(sunHourAngle: midnight,
                                                    moonHourAngle: moonHa,
                                                    observerLatitude: observerLat, moonDeclination: moonDecl),
                       7)
    }
    
}
