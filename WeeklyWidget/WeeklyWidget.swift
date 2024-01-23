//
//  WeeklyWidget.swift
//  WeeklyWidget
//
//  Created by Léo on 20/01/2024.
//

import WidgetKit
import SwiftUI
import HealthKit
struct Provider: TimelineProvider {
    let store = Store()
    func placeholder(in context: Context) -> WeekEntry {
        WeekEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (WeekEntry) -> ()) {
        completion(WeekEntry.placeholder)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        Task{
            
            guard HKHealthStore.isHealthDataAvailable() else {
                return
            }
            let allTypes = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,HKObjectType.workoutType()])

            store.healthStore.getRequestStatusForAuthorization(toShare: [], read: allTypes) { (status, error) in
                guard error == nil else {

                    // Handle the error here.
                    return
                }
                
                switch status {
                case .unnecessary:
                    Task {
                        let res = await store.fetch(weekAgo: 0)
                        let entry = WeekEntry(date: Date(), kCal: res.workouts.kCal, time: res.workouts.duration, qty: res.workouts.count)
                        
                        let timeline = Timeline(entries: [entry], policy: .atEnd)
                        completion(timeline)
                    }
                    // Authorization was previously granted.
                    print("Authorization already granted.")
                case .shouldRequest:

                    // You should request authorization.
                    // This means the user has not been prompted yet or the status has been reset.
                    print("You should request authorization.")
                case .unknown:

                    // Unable to determine the status. Rare case.
                    print("Status unknown.")
                @unknown default:

                    // Handle any future cases
                    print("Default case, status unknown.")
                }
                
            }
    }


        
    
}

struct WeekEntry: TimelineEntry {
    let date: Date
    let kCal : Int
    let time : TimeInterval
    let qty : Int
    static let placeholder = WeekEntry(date: Date(), kCal: 3202, time: 12600, qty: 3)
}

struct ErrorEntry: TimelineEntry {
    let date: Date
    let kCal : Int
    let time : TimeInterval
    let qty : Int
    static let placeholder = WeekEntry(date: Date(), kCal: 2300, time: 11110010010, qty: 3)
}

struct WeeklyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment:.leading){
            Text("Weekly Workouts").bold().font(.title)
            WeeklyHeaderView(kCal: entry.kCal, time: entry.time, qty: entry.qty, date: entry.date)
            Spacer()
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
    }
}

struct WeeklyWidget: Widget {
    let kind: String = "WeeklyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WeeklyWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WeeklyWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Weekly Workouts")
        .description("All your workout resumed in one view.")
        .supportedFamilies([.systemMedium])

    }
}

#Preview(as: .systemSmall) {
    WeeklyWidget()
} timeline: {
    WeekEntry.placeholder
    WeekEntry.placeholder
}
