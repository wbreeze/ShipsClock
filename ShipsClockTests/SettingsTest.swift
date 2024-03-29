//
  // SettingsTest
  // Created by Douglas Lovell on 20/8/21.
  // Copyright © 2021 Douglas Lovell
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

class SettingsTest: XCTestCase {
    let config = ClockConfiguration()

    override func setUpWithError() throws {
        config.reset()
    }

    func testShowLatLon() throws {
        XCTAssertFalse(config.showLatLon())
        config.showLatLon(true)
        XCTAssertTrue(config.showLatLon())
        XCTAssertFalse(config.showDirection())
    }
    
    func testShowDirection() throws {
        XCTAssertFalse(config.showDirection())
        config.showDirection(true)
        XCTAssertTrue(config.showDirection())
        XCTAssertFalse(config.showLatLon())
    }
}
