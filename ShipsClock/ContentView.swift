//
//  ContentView.swift
//  ShipsClock
//
//  Created by Douglas Lovell on 4/9/20.
//  Copyright © 2020 Douglas Lovell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var shipsClock: ShipsClock
    
    var body: some View {
        return VStack() {
            ClockFace()
            SituationDisplay().environmentObject(shipsClock.locationTracker)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
