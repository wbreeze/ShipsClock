//
  // WatchClock
  // Created by Douglas Lovell on 14/9/23.
  // Copyright © 2023 Douglas Lovell
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

/**
 Basic time model for the clock.
 */
class TimeModel : UpdatableClock, ObservableObject {
    @Published var timeOfDayInSeconds = 0
    @Published var utcTimeInSeconds = 0
    
    init() {
        updateClock()
    }
    
    func updateClock() {
        timeOfDayInSeconds = TimeModel.nextTime()
        utcTimeInSeconds = TimeModel.utcTime()
    }
    
    fileprivate static func timeInSeconds(_ cal: Calendar) -> Int {
        let now = Date()
        let hms = cal.dateComponents([.hour, .minute, .second], from: now)
        return timeInSeconds(hms)
    }
    
    fileprivate static func timeInSeconds(_ hms: DateComponents) -> Int {
        if let hour = hms.hour, let minute = hms.minute, let second = hms.second {
            return (hour * 60 + minute) * 60 + second
        } else {
            return 0
        }
    }
    
    static func nextTime() -> Int {
        return timeInSeconds(Calendar.current)
    }
    
    static func utcTime() -> Int {
        var cal = Calendar.current
        cal.timeZone = TimeZone.init(secondsFromGMT: 0) ?? TimeZone.current
        return timeInSeconds(cal)
    }
}
