//
  // WatchClock WatchKit Extension
  // Created by Douglas Lovell on 5/9/22.
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

class WatchClock {
    private var bell: BellRinger
    private var foregroundTicker: TimerTicker
    private var model: TimeModel

    init() {
        let bellSounds = BellSoundFile()
        bell = BellRinger(bell: bellSounds)
        model = TimeModel()
        foregroundTicker = TimerTicker(clock: model, bell: bell)
    }
    
    func moveToForeground() {
        bell.initializeLastPlayed(forTimeInSeconds: model.timeOfDayInSeconds)
        foregroundTicker.startTicking()
    }
}
