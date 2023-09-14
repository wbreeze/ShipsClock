//
  // TimerTicker
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

class TimerTicker {
    var clock: UpdatableClock
    var bell: BellRinger
    
    private var ticker: Timer?
    private let tickInterval = 1.0 // seconds
    
    init(clock: UpdatableClock, bell: BellRinger) {
        self.clock = clock
        self.bell = bell
    }

    private func updateTimeCallback(_: Timer) {
        clock.updateClock()
        bell.maybeRing(forTimeInSeconds: clock.timeOfDayInSeconds)
    }

    func startTicking() {
        ticker = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true, block: updateTimeCallback)
    }
    
    func stopTicking() {
        ticker?.invalidate()
    }
}
