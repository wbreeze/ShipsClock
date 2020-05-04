//
//  ShipsBellTest.swift
//  ShipsClockTests
//
//  Created by Douglas Lovell on 5/2/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import XCTest
@testable import ShipsClock

class ShipsBellTest: XCTestCase {
    
    var bellSystem = ShipsBell()

    func testHasBellMargins() throws {
        for halfHour in (0...7) {
            let currentTime = halfHour * 30 * 60
            XCTAssertEqual(bellSystem.halfHourIndex(forTimeInSeconds: currentTime), halfHour)
        }
    }
    
    func testPlayTheBell() throws {
        bellSystem.initializeLastPlayed(forTimeInSeconds: 0)
        bellSystem.maybeRing(forTimeInSeconds: 31 * 60)
        sleep(3)
    }
}
