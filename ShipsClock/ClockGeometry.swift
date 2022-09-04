//
// ShipsClock
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

import SwiftUI

class ClockGeometry {
    static func diameter(_ geometry : GeometryProxy) -> CGFloat {
        CGFloat.minimum(geometry.size.width, geometry.size.height)
    }
    
    static func radius(_ geometry : GeometryProxy) -> Double {
        Double(self.diameter(geometry)) / 2.0
    }
    
    static func hourAngle(forHour hour : Int) -> Double {
        let degrees = -Double(hour) * 360.0 / 24.0 - 90.0
        return degrees * Double.pi / 180.0
    }
    
    static func hourAngle(forTimeInSeconds: Int) -> Double {
        let lengthOfDayInSeconds = 24 * 60 * 60
        let partOfDay = Double(forTimeInSeconds) / Double(lengthOfDayInSeconds)
        return 3.0 * Double.pi / 2.0 - partOfDay * Double.pi * 2.0
    }
    
    static func pointOnRadius(
        forAngle angle: Double,
        givenRadius radius: Double,
        atPosition position: Double
    ) -> CGPoint
    {
        CGPoint(
            x: radius + cos(angle) * radius * position,
            y: radius - sin(angle) * radius * position
        )
    }
}
