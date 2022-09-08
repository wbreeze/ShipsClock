//
  // ShipsClock
  // Created by Douglas Lovell on 4/9/22.
  // Copyright © 2022 Douglas Lovell
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

class ClockModel : ObservableObject {
    @Published var timeOfDayInSeconds = 0
    @Published var utcTimeInSeconds = 0
    
    private var ticker: Timer?
    
    private let tickInterval = 1.0 // seconds
    
    init() {
        timeOfDayInSeconds = ClockModel.nextTime()
        utcTimeInSeconds = ClockModel.utcTime()
    }
    
    func moveToForeground() {
        updateClock() // right away, not at next tick
        ticker = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true, block: updateTimeCallback)
    }
    
    func moveToBackground() {
        ticker?.invalidate()
    }
    
    private func updateTimeCallback(_: Timer) {
        updateClock()
    }
    
    func updateClock() {
        timeOfDayInSeconds = ClockModel.nextTime()
        utcTimeInSeconds = ClockModel.utcTime()
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