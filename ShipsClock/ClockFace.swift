//
//  ClockFace.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import SwiftUI
import ShipsClockFramework

struct ClockFace: View {
    @EnvironmentObject var shipsClock: ShipsClock

    var body: some View {
        GeometryReader { geometry in
            let currentDiameter = ClockGeometry.diameter(geometry)
            ZStack {
                let currentRadius = ClockGeometry.radius(geometry)
                ClockBackground(radius: currentRadius)
                ClockSun(radius: currentRadius).environmentObject(self.shipsClock.celestialComputer)
                ClockMoon(radius: currentRadius).environmentObject(self.shipsClock.celestialComputer)
                ClockHands(radius: currentRadius, timeOfDayInSeconds: shipsClock.timeOfDayInSeconds)
            }.frame(width: currentDiameter, height: currentDiameter, alignment: .top)
        }
    }
}

struct ClockFace_Previews: PreviewProvider {
    static var previews: some View {
        ClockFace()
    }
}
