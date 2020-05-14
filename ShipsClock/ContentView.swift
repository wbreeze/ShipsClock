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
        
        var body: some View {
            VStack {
                ClockFace()
                SituationDisplay().environmentObject(shipsClock.locationTracker)
            }
        }
    }
    
    struct Horizontal: View {
        @EnvironmentObject var shipsClock: ShipsClock
        
        var body: some View {
            HStack(alignment: .top, spacing: nil) {
                ClockFace()
                SituationDisplay().environmentObject(shipsClock.locationTracker)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if (geometry.size.width <= geometry.size.height) {
                Vertical()
            } else {
                Horizontal()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
