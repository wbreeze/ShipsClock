//
  // ShipsClock
  // Created by Douglas Lovell on 23/5/21.
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
  

import SwiftUI

struct ClockUTC: View {
    @EnvironmentObject var shipsClock: ShipsClock
    var radius : Double

    let pointerPositionMultiplier = 0.77
    let pointerSizeMultiplier = 44.0
    
    var body: some View {
        let hourAngle = ClockGeometry.hourAngle(forTimeInSeconds: self.shipsClock.utcTimeInSeconds)
        let center = ClockGeometry.pointOnRadius(forAngle: hourAngle, givenRadius: radius, atPosition: pointerPositionMultiplier)
        let scale = CGFloat(radius / pointerSizeMultiplier)
        let transform = CGAffineTransform.identity
            .concatenating(CGAffineTransform.identity.scaledBy(x: scale, y: scale))
            .concatenating(CGAffineTransform.identity.rotated(by: CGFloat(-hourAngle + 3.0 * Double.pi / 2.0)))
            .concatenating(CGAffineTransform.identity.translatedBy(x: center.x, y: center.y))

        return Path() { path in
            path.move(to: CGPoint(x: 0, y: 2))
            path.addLine(to: CGPoint(x: 2, y: -3))
            path.addLine(to: CGPoint(x: -2, y: -3))
            path.addLine(to: CGPoint(x: 0, y: 2))
        }.transform(transform).fill()

    }
}

struct ClockUTC_Previews: PreviewProvider {
    static var previews: some View {
        ClockUTC(radius: 200.0).environmentObject(ShipsClock())
    }
}
