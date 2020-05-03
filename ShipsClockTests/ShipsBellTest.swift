//
//  ShipsBellTest.swift
//  ShipsClockTests
//
//  Created by Douglas Lovell on 5/2/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import XCTest

class ShipsBellTest: XCTestCase {
    
    let bellSystem = ShipsBell()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasWatchMargins() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testWatch = ShipsWatch.middleWatch
        XCTAssertEqual(bellSystem.watchFor(timeInSeconds: testWatch.startTime), testWatch)
    }
}
