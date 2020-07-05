//
//  ClockHands.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import SwiftUI

struct ClockHands: View {
    @EnvironmentObject var shipsClock: ShipsClock
    var radius : Double

    var body: some View {
        ZStack {
            MinuteHand(
                radius: self.radius, timeInSeconds: self.shipsClock.timeOfDayInSeconds)
            HourHand(
                radius: self.radius, timeInSeconds: self.shipsClock.timeOfDayInSeconds)
            WatchHand(
                radius: self.radius, timeInSeconds: self.shipsClock.timeOfDayInSeconds)
            CenterCircle(radius: self.radius)
        }
    }

    struct HourHand: View {
        var radius: Double
        var timeInSeconds: Int
        
        let hourHandStart = -0.1
        let hourHandEnd = 0.55
        
        var body: some View {
            Path() { path in
                let lengthOfDayInSeconds = 24 * 60 * 60
                let partOfDay = Double(timeInSeconds) / Double(lengthOfDayInSeconds)
                let hourAngle = 3.0 * Double.pi / 2.0 - partOfDay * Double.pi * 2.0
                path.move(to: ClockFace.pointOnRadius(forAngle: hourAngle, givenRadius: radius, atPosition: hourHandStart))
                path.addLine(to: ClockFace.pointOnRadius(forAngle: hourAngle, givenRadius: radius, atPosition: hourHandEnd))
            }.stroke(lineWidth: CGFloat(radius / 22.0))
        }
    }
    
    struct WatchWand: View {
        let transform: CGAffineTransform
        
        init(radius: Double, watchAngle: Double, atPosition watchHandEnd: Double) {
            let center = ClockFace.pointOnRadius(forAngle: watchAngle, givenRadius: radius, atPosition: watchHandEnd)
            let scale = CGFloat(radius / 90.0)
            transform = CGAffineTransform.identity
                .concatenating(CGAffineTransform.identity.scaledBy(x: scale, y: scale))
                .concatenating(CGAffineTransform.identity.rotated(by: CGFloat(-watchAngle)))
                .concatenating(CGAffineTransform.identity.translatedBy(x: center.x, y: center.y))
        }

        var body: some View {
            Path() { path in
                path.move(to: CGPoint(x: 0, y: 3))
                path.addLine(to: CGPoint(x: -3, y: 0))
                path.addLine(to: CGPoint(x: 0, y: -3))
                path.addLine(to: CGPoint(x: 0, y: 3))
            }.transform(transform).fill()
        }
    }
    
    struct WatchHand: View {
        let watchHandStart = -0.1
        let watchHandEnd = 0.68

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
                }.stroke(lineWidth: CGFloat(radius / 35.0))
                WatchWand(radius: radius, watchAngle: watchAngle, atPosition: watchHandEnd)
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
            }.stroke(lineWidth: CGFloat(radius / 22.0))
        }
    }
    
    struct CenterCircle: View {
        var radius: Double
        
        var body: some View {
            let centerSize = CGFloat(radius / 45.0)
            let offset = CGFloat(radius) - centerSize / 2.0
            return Circle()
                .size(width: centerSize, height: centerSize)
                .offset(x: offset, y: offset)
                .fill(Color(UIColor.systemBackground))
        }
    }
}

struct ClockHands_Previews: PreviewProvider {
    static var previews: some View {
        ClockHands(radius: 200.0)
    }
}
