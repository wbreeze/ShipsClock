//
  // WatchClock WatchKit Extension
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
  

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var clockModel: ClockModel
    
    var body: some View {
        GeometryReader { geometry in
            let currentDiameter = ClockGeometry.diameter(geometry)
            ZStack {
                let currentRadius = ClockGeometry.radius(geometry)
                ClockBackground(radius: currentRadius)
                ClockHands(radius: currentRadius).environmentObject(clockModel)
            }.frame(width: currentDiameter, height: currentDiameter).offset(x:CGFloat((geometry.size.width - currentDiameter) / 2.0), y:CGFloat(4.0 + (geometry.size.height - currentDiameter) / 2.0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ClockModel()
        Group {
            ContentView().previewDevice("Apple Watch Series 5 - 40mm").environmentObject(model)
            ContentView().previewDevice("Apple Watch Series 7 - 45mm").environmentObject(model)
        }
    }
}
