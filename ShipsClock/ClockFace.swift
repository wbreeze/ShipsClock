//
//  ClockFace.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import SwiftUI

struct ClockFace: View {
    @EnvironmentObject var shipsClock: ShipsClock

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

    var body: some View {
        GeometryReader { geometry in
            let currentDiameter = ClockFace.diameter(geometry)
            ZStack {
                let currentRadius = ClockFace.radius(geometry)
                ClockBackground(radius: currentRadius)
                ClockSun(radius: currentRadius).environmentObject(self.shipsClock.celestialComputer)
                ClockMoon(radius: currentRadius).environmentObject(self.shipsClock.celestialComputer)
                ClockHands(radius: currentRadius).environmentObject(self.shipsClock)
            }.frame(width: currentDiameter, height: currentDiameter, alignment: .top)
        }
    }
}

struct ClockFace_Previews: PreviewProvider {
    static var previews: some View {
        ClockFace()
    }
}
