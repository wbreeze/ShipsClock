//
//  ContentView.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    struct Vertical: View {
        @EnvironmentObject var shipsClock: ShipsClock
        
        var displaySize: CGFloat
        
        var body: some View {
            VStack {
                ClockFace(shipsClock: shipsClock)
                SituationDisplay(displayWidth: displaySize)
                    .environmentObject(shipsClock.locationTracker)
            }
        }
    }
    
    struct Horizontal: View {
        @EnvironmentObject var shipsClock: ShipsClock
        
        var displaySize: CGFloat
        
        var body: some View {
            HStack(alignment: .top, spacing: nil) {
                ClockFace(shipsClock: shipsClock)
                SituationDisplay(displayWidth: displaySize)
                    .environmentObject(shipsClock.locationTracker)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if (geometry.size.width <= geometry.size.height) {
                Vertical(displaySize: geometry.size.width)
            } else {
                Horizontal(displaySize: geometry.size.height)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
