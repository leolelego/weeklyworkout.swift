//
//  WeeklyView.swift
//  HealthData
//
//  Created by Léo on 19/01/2024.
//

import SwiftUI
import HealthKit
struct WeeklyView: View {
    var weekAgo : Int
    @EnvironmentObject private var  store : Store
    @State private var groupedWorkouts = [String: [HKWorkout]]() //workouts : [HKWorkout] = []
    @State private var loading = true
    @State private var monday = Date.now

    var body: some View {
        VStack(alignment: groupedWorkouts.values.count < 1 ? .center : .leading){
            if loading {
               ProgressView().progressViewStyle(CircularProgressViewStyle())
            } else if groupedWorkouts.values.count < 1 {
                Text("No Workout this week 🥺").bold()
                Text(monday.weekString()).foregroundColor(.gray).font(.callout).bold()
            } else {
//                VStack(alignment: .leading){
                    WeeklyHeaderView(kCal: groupedWorkouts.values.map { $0.kCal }.reduce(0, +), time: groupedWorkouts.values.map { $0.duration }.reduce(0, +), qty: groupedWorkouts.values.map { $0.count }.reduce(0, +),date: monday)
                    .padding(.horizontal)
                    List {
                        ForEach(groupedWorkouts.keys.sorted(by: <),id:\.self){ key in
                            Section(header: Text(section(string:key))) {
                                ForEach( groupedWorkouts[key]!,id: \.startDate){ w in
                                    WorkoutView(workout: w)
                                }
                            }
                        }
                    }.refreshable {
                        featch()
                    }
//                }
            }
        }.onAppear {
            featch()
        }
    }
    
    func featch(){
        Task {
            self.loading = true

            groupedWorkouts = [:]
            let res = await store.fetch(weekAgo: weekAgo)
            self.monday = res.monday
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust the format as needed

            // Dictionary to hold the grouped dates
            

            // Group the dates
            for workout in res.workouts {
                let dateString = dateFormatter.string(from: workout.startDate)
                groupedWorkouts[dateString, default: []].append(workout)
            }
            
            self.loading = false
        }
    }
    
    func section(string:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Set this to match the format of your date string
        guard let date = dateFormatter.date(from: string) else  {
            return "Err"
        }
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE"
        
        return dateFormatter2.string(from: date)
        
    }
}
