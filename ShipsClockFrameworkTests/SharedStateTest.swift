//
  // ShipsClockFrameworkTests
  // Created by Douglas Lovell on 25/10/21.
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
@testable import ShipsClockFramework

class SharedStateFrameworkTest: XCTestCase {
    var ss = SharedState()
    let fm = FileManager.default

    func clearState() throws {
        let path = ss.fileURL()?.path
        if (fm.fileExists(atPath: path!)) {
            try fm.removeItem(atPath: path!)
        }
    }
    
    override func setUpWithError() throws {
        try clearState()
    }

    override func tearDownWithError() throws {
        try clearState()
    }

    func testPersistToFile() throws {
        let path = ss.fileURL()?.path
        ss.setWidgetToRing()
        XCTAssertTrue(fm.fileExists(atPath: path!))
    }
            
    func testDefaultState() throws {
        XCTAssertFalse(ss.widgetDoesRing())
    }
    
    func testReadState() throws {
        ss.setWidgetToRing()
        XCTAssertTrue(ss.widgetDoesRing())
    }
    
    func testClockDoesRing() throws {
        ss.setWidgetToRing()
        XCTAssertTrue(ss.widgetDoesRing())
        ss.setClockToRing()
        XCTAssertFalse(ss.widgetDoesRing())
    }
}
