//
// ShipsClock
// Created by Douglas Lovell on 11/20/20.
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

struct ClockMoon: View {
    @EnvironmentObject var computer: CelestialComputer
    var radius : Double
    
    let textRadiusMultiplier = 0.75

    var body: some View {
        let moons = Array("🌑🌒🌓🌔🌕🌖🌗🌘")
        var moon = ""
        var angle = 0.0
        if let moonAngle = computer.moonHourAngle {
            if let phase = computer.moonPhase {
                moon = String.init(moons[phase])
            } else {
                moon = "🌕"
            }
            angle = (90.0 - moonAngle) * Double.pi / 180.0
        }
        return Text(moon)
            .position(ClockGeometry.pointOnRadius(forAngle: angle, givenRadius: radius, atPosition: textRadiusMultiplier))
            .font(.system(size: CGFloat(self.radius / 9.0), weight: .black, design: .default))
    }
}

struct ClockMoon_Previews: PreviewProvider {
    static var previews: some View {
        ClockMoon(radius: 1.0)
    }
}
