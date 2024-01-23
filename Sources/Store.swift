//
//  Store.swift
//  HealthData
//
//  Created by Léo on 19/01/2024.
//

import Foundation
import HealthKit

class Store  : ObservableObject{ // ObservableObject
    let healthStore = HKHealthStore()
    private(set) var workouts : [HKWorkout] = [] // @Published

    func setup() async -> Bool{
        guard HKHealthStore.isHealthDataAvailable() else {
            return false
        }

        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,HKObjectType.workoutType()])
//        healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
//            self.objectWillChange.send()
//             = success
//        }
        do {
           try  await healthStore.requestAuthorization(toShare: [], read: allTypes)
            print("Acces authorized")
            return true
        } catch{
            print("Acces NOT authorized")

            return false
        }
    }
    
//    func checkAutho(completion:@escaping ()->Void){
//        guard HKHealthStore.isHealthDataAvailable() else {
//            completion(false)
//            return
//        }
//        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,HKObjectType.workoutType()])
//
//        healthStore.getRequestStatusForAuthorization(toShare: [], read: allTypes) { (status, error) in
//            guard error == nil else {
//                completion(false)
//
//                // Handle the error here.
//                return
//            }
//            
//            switch status {
//            case .unnecessary:
//                // Authorization was previously granted.
//                completion(true)
//                print("Authorization already granted.")
//            case .shouldRequest:
//                completion(true)
//
//                // You should request authorization.
//                // This means the user has not been prompted yet or the status has been reset.
//                print("You should request authorization.")
//            case .unknown:
//                completion(true)
//
//                // Unable to determine the status. Rare case.
//                print("Status unknown.")
//            @unknown default:
//                completion(true)
//
//                // Handle any future cases
//                print("Default case, status unknown.")
//            }
//        }
//        
//    }

    func fetch(weekAgo : Int ) async -> (monday:Date,workouts:[HKWorkout]) {
        let calendar = NSCalendar.current

        let wantedDate = calendar.date(byAdding: .day, value: -weekAgo*7, to: Date())!
   
        let start = mondayOf(date: wantedDate)
        let end = sundayOf(date: wantedDate)

        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)

        print("Fetch DATA for \(weekAgo) -> \(start) to \(end)")

        let anchorDescriptor = HKAnchoredObjectQueryDescriptor(predicates: [.workout(predicate)], anchor: nil)
        do {
            let results = try await anchorDescriptor.result(for: healthStore)
            return (start,results.addedSamples)
        } catch {
            return (start,[])
        }
    }
    
    func mondayOf(date:Date)-> Date{
        let monday = date.previous(.monday,
                                           considerToday: true)
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: monday)
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 1

        return Calendar.current.date(from: dateComponents)!
    }
    
    
    func sundayOf(date:Date)-> Date{
        let sunday = date.next(.sunday,
                                     considerToday: true)
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: sunday)
        dateComponents.hour = 23
        dateComponents.minute = 59
        dateComponents.second = 59

        return Calendar.current.date(from: dateComponents)!
    }

    
}
