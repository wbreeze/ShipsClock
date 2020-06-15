//
//  ClockBackground.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import SwiftUI

struct ClockBackground: View {
    let borderColor = Color.black
    var radius: Double
    
    var body: some View {
        ZStack {
            self.border
            Numbers(radius: self.radius)
            Ticks(radius: self.radius)
        }
    }

    var border: some View {
        Circle().stroke(borderColor, lineWidth: 4)
    }
    
    struct HourTicks: View {
        var tickColor = Color.black
        
        var radius : Double
        var hourInterval : Int
        var widthMultiplier : Int
        var tickOutside : Double
        var tickInside : Double

        var body: some View {
            let baseLineWidth = CGFloat(radius / 60.0)
            return Path { path in
                for hour in stride(from: 0, to: 23, by: hourInterval) {
                    let angle = ClockFace.hourAngle(forHour: hour)
                    path.move(to: ClockFace.pointOnRadius(forAngle: angle, givenRadius: radius, atPosition: self.tickOutside))
                    path.addLine(to: ClockFace.pointOnRadius(forAngle: angle, givenRadius: radius, atPosition: self.tickInside))
                }
            }
            .stroke(lineWidth: CGFloat(widthMultiplier) * baseLineWidth)
            .fill(self.tickColor)
        }
    }

    struct Ticks: View {
        var radius: Double
        let watchTicksOutside = 0.8
        let watchTicksInside = 0.7
        let watchesTicksOutside = 0.68
        let watchesTicksInside = 0.6

        var body: some View {
            ZStack {
                HourTicks(radius: radius, hourInterval: 4, widthMultiplier: 1, tickOutside: watchesTicksOutside, tickInside: watchesTicksInside)
                HourTicks(radius: radius, hourInterval: 6, widthMultiplier: 2, tickOutside: watchTicksOutside, tickInside: watchTicksInside)
            }
        }
    }
        
    struct PositionedHourLabel: View {
        let textRadiusMultiplier = 0.9
        let hour: Int
        let radius: Double
        let angle: Double
        
        var body: some View {
            Text(hour.description)
                .position(ClockFace.pointOnRadius(forAngle: angle, givenRadius: radius, atPosition: textRadiusMultiplier))
        }
    }
    
    struct Numbers: View {
        let hourCount = 24
        let radius: Double
        
        var body: some View {
            return ForEach(0..<self.hourCount, content: { hour in
                PositionedHourLabel(
                    hour: hour,
                    radius: self.radius,
                    angle: ClockFace.hourAngle(forHour: hour)
                ).font(.system(size: CGFloat(self.radius / 9.0), weight: .black, design: .default))
            })
        }
    }
}

struct ClockBackground_Previews: PreviewProvider {
    static var previews: some View {
        ClockBackground(radius: 200)
    }
}
