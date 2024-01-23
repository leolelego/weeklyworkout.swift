//
//  WorkoutView.swift
//  WeeklyWorkout
//
//  Created by Léo on 22/01/2024.
//

import SwiftUI
import HealthKit
struct WorkoutView: View {
    var workout : HKWorkout
    var body: some View {
        HStack(alignment: .top){
            Text(workout.workoutActivityType.emoji).font(.title)
            VStack(alignment: .leading){
                Text("Time").foregroundColor(.green).bold()//.font(.title3)
                Text(workout.durationString).bold().font(.title3)
                if workout.distance > 0{
                    Text("Distance").foregroundColor(.cyan).bold()//.font(.title3)
                    HStack(){
                        Text(String(format: "%.2f", workout.distance)).bold().font(.title3)
                        Text("km").foregroundColor(.gray)
                    }
                }
            }
            Spacer()

            VStack(alignment: .leading){
                Text("Move").foregroundColor(.red).bold()//.font(.title3)
                HStack(){
                    Text("\(workout.kCal)").bold().font(.title3)
                    Text("kcal").foregroundColor(.gray)
                }
            }
            Spacer()
        }
        
    }
}

//#Preview {
//    WorkoutView(workout: HKWorkout(activityType: .americanFootball, start: .now, end: .now+3678, workoutEvents: nil, totalEnergyBurned: HKQuantity(unit: .kilocalorie(), doubleValue: 200), totalDistance: HKQuantity(unit: .meter(), doubleValue: 3.4), metadata: nil)).frame(width: 400,height: 400)
//    
//}
