//
  // ShipsClockWidget
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
  

import WidgetKit
import SwiftUI
import ShipsClockFramework

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> BellEntry {
        BellEntry(date: Date(), sound: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (BellEntry) -> ()) {
        let entry = BellEntry(date: Date(), sound: nil)
        completion(entry)
    }

    func ringTimeline() -> [BellEntry] {
        var entries: [BellEntry] = []

        let bell = ShipsBell()
        for period in bell.bellSchedule() {
            let entry = BellEntry(date: period.timing.date ?? Date(), sound: period.bellSound)
            entries.append(entry)
        }
        
        return entries
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var widgetState = SharedState()
        var timeline : Timeline<BellEntry>
        
        if (widgetState.widgetDoesRing()) {
            timeline = Timeline<BellEntry>(entries: ringTimeline(), policy: .atEnd)
        } else {
            timeline = Timeline<BellEntry>(entries: [], policy: .never)
        }
        
        completion(timeline)
    }
}

struct BellEntry: TimelineEntry, Equatable {
    var date: Date
    let sound: String?
}

struct ShipsClockWidgetEntryView : View {
    var entry: Provider.Entry

    func maybeRingBell(_ : Provider.Entry) {
        if let soundName = entry.sound {
            let bell = ShipsBell()
            var ringer = TimerRinger(bell: bell)
            ringer.playNamedSoundFile(soundName)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let currentDiameter = ClockGeometry.diameter(geometry)
            ZStack {
                let currentRadius = ClockGeometry.radius(geometry)
                ClockBackground(radius: currentRadius)
                ClockHands(radius: currentRadius, timeOfDayInSeconds: CalendarTime.timeOfDayInSeconds())
            }.frame(width: currentDiameter, height: currentDiameter, alignment: .top)
                .onChange(of: entry, perform: maybeRingBell)
        }
    }
}

@main
struct ShipsClockWidget: Widget {
    let kind: String = "shipsclock.com.wbreeze"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ShipsClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Ships Clock")
        .description("Display the time on a 24 hour clock and chime each half hour.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct ShipsClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        ShipsClockWidgetEntryView(entry: BellEntry(date: Date(), sound: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
