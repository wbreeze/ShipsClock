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
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct ShipsClockWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { geometry in
            let currentDiameter = ClockGeometry.diameter(geometry)
            ZStack {
                let currentRadius = ClockGeometry.radius(geometry)
                ClockBackground(radius: currentRadius)
                ClockHands(radius: currentRadius, timeOfDayInSeconds: CalendarTime.timeOfDayInSeconds())
            }.frame(width: currentDiameter, height: currentDiameter, alignment: .top)
        }
    }
}

@main
struct ShipsClockWidget: Widget {
    let kind: String = "ShipsClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ShipsClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Ships Clock")
        .description("Display the time on a 24 hour clock and chime each half hour.")
    }
}

struct ShipsClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        ShipsClockWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
