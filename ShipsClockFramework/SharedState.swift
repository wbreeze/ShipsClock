//
  // ShipsClockFramework
  // Created by Douglas Lovell on 27/10/21.
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
  

import Foundation

public struct SharedState {
    let SHIPSCLOCK_FILE_GROUP = "shipsclock.com.wbreeze"
    let fm = FileManager.default
    var state = StateData(widgetRings: false)

    struct StateData : Codable {
        var widgetRings : Bool
    }
    
    public init() {}
    
    public func fileURL() -> URL? {
        let dirURL = fm.containerURL(forSecurityApplicationGroupIdentifier: SHIPSCLOCK_FILE_GROUP)?
            .appendingPathComponent("tmp")
        do {
            let dirPath = dirURL!.path
            let isDir = fm.fileExists(atPath: dirPath)
            if (!isDir) {
                try fm.createDirectory(at: dirURL!, withIntermediateDirectories: true)
            }
            let sharedURL = dirURL!.appendingPathComponent("shared.state.plist")
            return sharedURL
        }
        catch {
            return nil
        }
    }
    
    mutating func readStateFromFile() {
        let persistURL = fileURL()!
        let decoder = PropertyListDecoder()
        do {
            let data = try Data.init(contentsOf: persistURL)
            state = try decoder.decode(StateData.self, from: data)
        }
        catch {
            print("Unable to read state")
        }
    }
    
    mutating func persistState() {
        let persistURL = fileURL()!
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(state)
            try data.write(to: persistURL)
        } catch {
            print("Unable to write state")
        }
    }
    
    public mutating func setWidgetToRing() {
        if (!state.widgetRings) {
            state.widgetRings = true
            persistState()
        }
    }
    
    public mutating func setClockToRing() {
        if (state.widgetRings) {
            state.widgetRings = false
            persistState()
        }
    }
    
    public mutating func widgetDoesRing() -> Bool {
        readStateFromFile()
        return state.widgetRings
    }
}
