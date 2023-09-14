//
//  ClockFace.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import SwiftUI

struct ClockFace: View {
    @ObservedObject var clockModel: ClockModel

    var body: some View {
        GeometryReader { geometry in
            let currentDiameter = ClockGeometry.diameter(geometry)
            ZStack {
                let currentRadius = ClockGeometry.radius(geometry)
                ClockBackground(radius: currentRadius)
                ClockUTC(timeModel: self.clockModel, radius: currentRadius)
                ClockSun(radius: currentRadius).environmentObject(self.clockModel.celestialComputer)
                ClockMoon(radius: currentRadius).environmentObject(self.clockModel.celestialComputer)
                ClockHands(timeModel: self.clockModel, radius: currentRadius)
            }.frame(width: currentDiameter, height: currentDiameter, alignment: .top)
        }
    }
}

struct ClockFace_Previews: PreviewProvider {
    static var previews: some View {
        ClockFace(clockModel: ClockModel(locationTracker: LocationTracker()))
    }
}
