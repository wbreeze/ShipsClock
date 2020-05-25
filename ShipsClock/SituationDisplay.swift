//
  // ShipsClock
  // Created by Douglas Lovell on 5/13/20.
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
  

import SwiftUI

struct SituationDisplay: View {
    @EnvironmentObject var location: LocationTracker
    
    var displayWidth: CGFloat

    var body: some View {
        return VStack(alignment: .leading, spacing: nil) {
            if location.isValidLocation {
                Text(LocationTracker.format(degrees: location.latitude, isLongitude: false))
                Text(LocationTracker.format(degrees: location.longitude, isLongitude: true))
                Text(location.courseAndSpeed()).lineLimit(1)
                    .font(.system(size: CGFloat(displayWidth / 10.0), weight: .bold, design: .monospaced))
                    .minimumScaleFactor(0.5)
            } else {
                Text("Latitude and longitude are not available.")
            }
        }
    }
}

struct SituationDisplay_Previews: PreviewProvider {
    static var previews: some View {
        SituationDisplay(displayWidth: 320.0).environmentObject(LocationTracker())
    }
}
