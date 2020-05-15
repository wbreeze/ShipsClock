//
//  ClockFace.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import SwiftUI

struct ClockFace: View {
    let secondHandColor = Color.red
    let minuteHandColor = Color.black
    let hourHandColor = Color.black
    let watchHandColor = Color.black
    let backgroundColor = Color.white
    let borderColor = Color.black
    let centerColor = Color.red
    
    @EnvironmentObject var shipsClock: ShipsClock

    func diameter(_ geometry : GeometryProxy) -> CGFloat {
        CGFloat.minimum(geometry.size.width, geometry.size.height)
    }

    func radius(_ geometry : GeometryProxy) -> Double {
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
            ZStack {
                self.border
                Numbers(radius: self.radius(geometry))
                Ticks(radius: self.radius(geometry))
                MinuteHand(
                    radius: self.radius(geometry), timeInSeconds: self.shipsClock.timeOfDayInSeconds)
                HourHand(
                    radius: self.radius(geometry), timeInSeconds: self.shipsClock.timeOfDayInSeconds)
                WatchHand(
                    radius: self.radius(geometry), timeInSeconds: self.shipsClock.timeOfDayInSeconds)
                // CenterCircle(radius: self.radius(geometry)
            }.frame(width: self.diameter(geometry), height: self.diameter(geometry), alignment: .top)
        }
    }

    var border: some View {
        Circle().stroke(borderColor, lineWidth: 4)
    }
    
    struct HourTicks: View {
        var baseLineWidth = CGFloat(3.0)
        var tickColor = Color.black
        
        var radius : Double
        var hourInterval : Int
        var widthMultiplier : Int
        var tickOutside : Double
        var tickInside : Double

        var body: some View {
            Path { path in
                for hour in stride(from: 0, to: 23, by: hourInterval) {
                    let angle = ClockFace.hourAngle(forHour: hour)
                    path.move(to: ClockFace.pointOnRadius(forAngle: angle, givenRadius: radius, atPosition: self.tickOutside))
                    path.addLine(to: ClockFace.pointOnRadius(forAngle: angle, givenRadius: radius, atPosition: self.tickInside))
                }
            }
            .stroke(lineWidth: CGFloat(widthMultiplier) * self.baseLineWidth)
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

    struct HourHand: View {
        var radius: Double
        var timeInSeconds: Int
        
        let hourHandStart = -0.1
        let hourHandEnd = 0.5
        
        var body: some View {
            Path() { path in
                let lengthOfDayInSeconds = 24 * 60 * 60
                let partOfDay = Double(timeInSeconds) / Double(lengthOfDayInSeconds)
                let hourAngle = 3.0 * Double.pi / 2.0 - partOfDay * Double.pi * 2.0
                path.move(to: ClockFace.pointOnRadius(forAngle: hourAngle, givenRadius: radius, atPosition: hourHandStart))
                path.addLine(to: ClockFace.pointOnRadius(forAngle: hourAngle, givenRadius: radius, atPosition: hourHandEnd))
            }.stroke(lineWidth: 10.0)
        }
    }
    
    struct WatchWand: View {
        let watchHandEnd = 0.6

        let radius: Double
        let transform: CGAffineTransform
        
        init(radius: Double, watchAngle: Double) {
            self.radius = radius
            let center = ClockFace.pointOnRadius(forAngle: watchAngle, givenRadius: radius, atPosition: watchHandEnd)
            transform = CGAffineTransform.identity
                .concatenating(CGAffineTransform.identity.scaledBy(x: 4.0, y: 4.0))
                .concatenating(CGAffineTransform.identity.rotated(by: CGFloat(-watchAngle)))
                .concatenating(CGAffineTransform.identity.translatedBy(x: center.x, y: center.y))
        }

        var body: some View {
            Path() { path in
                path.move(to: CGPoint(x: 1, y: 3))
                path.addLine(to: CGPoint(x: -2, y: 0))
                path.addLine(to: CGPoint(x: 1, y: -3))
                path.addLine(to: CGPoint(x: 1, y: 3))
            }.transform(transform).fill(Color.black)
        }
    }
    
    struct WatchHand: View {
        let watchHandStart = -0.1
        let watchHandEnd = 0.6

        let lengthOfWatchInSeconds = 4 * 60 * 60
        let radius: Double
        let watchAngle: Double

        init(radius: Double, timeInSeconds: Int) {
            self.radius = radius
            let watchRemainder = timeInSeconds % lengthOfWatchInSeconds
            let partOfWatch = Double(watchRemainder) / Double(lengthOfWatchInSeconds)
            watchAngle = Double.pi / 2.0 - partOfWatch * Double.pi * 2.0
        }
        
        var body: some View {
            ZStack {
                Path() { path in
                    path.move(to: ClockFace.pointOnRadius(forAngle: watchAngle, givenRadius: radius, atPosition: watchHandStart))
                    path.addLine(to: ClockFace.pointOnRadius(forAngle: watchAngle, givenRadius: radius, atPosition: watchHandEnd))
                }.stroke(lineWidth: 6.0)
                WatchWand(radius: radius, watchAngle: watchAngle)
            }
        }
    }
    
    struct MinuteHand: View {
        var radius: Double
        var timeInSeconds: Int
        
        let minuteHandStart = -0.1
        let minuteHandEnd = 0.8
        
        var body: some View {
            Path() { path in
                let lengthOfHourInSeconds = 60 * 60
                let hourRemainder = timeInSeconds % lengthOfHourInSeconds
                let partOfHour = Double(hourRemainder) / Double(lengthOfHourInSeconds)
                let minuteAngle = Double.pi / 2.0 - partOfHour * Double.pi * 2.0
                path.move(to: ClockFace.pointOnRadius(forAngle: minuteAngle, givenRadius: radius, atPosition: minuteHandStart))
                path.addLine(to: ClockFace.pointOnRadius(forAngle: minuteAngle, givenRadius: radius, atPosition: minuteHandEnd))
            }.stroke(lineWidth: 10.0)
        }
    }
}

struct ClockFace_Previews: PreviewProvider {
    static var previews: some View {
        ClockFace()
    }
}
