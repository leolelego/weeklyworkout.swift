//
//  HKWorkout+Ext.swift
//  HealthData
//
//  Created by Léo on 19/01/2024.
//

import Foundation
import HealthKit

extension HKWorkout {
    var durationString : String {
        return duration.stringTime
    }
    
    var kCal : Int {
        guard let cal = statistics(for: HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!)?.sumQuantity()?.doubleValue(for: .kilocalorie()) else {
            return 0
        }
        return Int(cal)
    }

    var distance : Double {
        
        let cycling = statistics(for: HKObjectType.quantityType(forIdentifier: .distanceSwimming)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0
        let swimming = statistics(for: HKObjectType.quantityType(forIdentifier: .distanceCycling)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0
        let running  = statistics(for: HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0
        let wheelchair   = statistics(for: HKObjectType.quantityType(forIdentifier: .distanceWheelchair)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0
        let winter   = statistics(for: HKObjectType.quantityType(forIdentifier: .distanceDownhillSnowSports)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0

        return (cycling + swimming + running + wheelchair + winter ) / 1000
    }
//    var distance : Double {
//        
//        let cycling = statistics(for: HKObjectType.quantityType(forIdentifier: .heartRate)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0
//        let swimming = statistics(for: HKObjectType.quantityType(forIdentifier: .distanceCycling)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0
//        let running  = statistics(for: HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0
//        let wheelchair   = statistics(for: HKObjectType.quantityType(forIdentifier: .distanceWheelchair)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0
//        let winter   = statistics(for: HKObjectType.quantityType(forIdentifier: .distanceDownhillSnowSports)!)?.sumQuantity()?.doubleValue(for: .meter()) ?? 0
//
//        return (cycling + swimming + running + wheelchair + winter ) / 1000
//    }
}


extension Array where  Element:HKWorkout {
    var kCal : Int {
        return self.compactMap { return $0.kCal}.reduce(0, +)
    }
    var duration : TimeInterval {
        return self.compactMap { return $0.duration}.reduce(0, +)
    }
}


extension Date {
    
    func weekString()->String{
        let monday = previous(.monday,considerToday: true)
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        
        let sunday = next(.sunday)
        let formattedInterval = formatter.string(from: monday, to: sunday)
        return formattedInterval
        
    }
}

// -----

extension TimeInterval {
     var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }

     var seconds: Int {
        return Int(self) % 60
    }

     var minutes: Int {
        return (Int(self) / 60 ) % 60
    }

     var hours: Int {
        return Int(self) / 3600
    }

    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
    var stringTimeShort: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}
