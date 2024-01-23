//
//  HKWorkoutActivityType+ext.swift
//  WeeklyWorkout
//
//  Created by Léo on 22/01/2024.
//
import HealthKit

extension HKWorkoutActivityType {
    var emoji: String {
        switch self {
        case .americanFootball: return "🏈"
        case .archery: return "🏹"
        case .australianFootball: return "🏉"
        case .badminton: return "🏸"
        case .baseball: return "⚾️"
        case .basketball: return "🏀"
        case .bowling: return "🎳"
        case .boxing: return "🥊"
        case .climbing: return "🧗‍♂️"
        case .cricket: return "🏏"
        case .crossTraining: return "🏋️"
        case .curling: return "🥌"
        case .cycling: return "🚴‍♀️"
        case .dance: return "💃"
        case .danceInspiredTraining: return "💃"
        case .elliptical: return "🚶‍♀️"
        case .equestrianSports: return "🏇"
        case .fencing: return "🤺"
        case .fishing: return "🎣"
        case .functionalStrengthTraining: return "🏋️"
        case .golf: return "🏌️‍♂️"
        case .gymnastics: return "🤸‍♂️"
        case .handball: return "🤾‍♂️"
        case .hiking: return "🥾"
        case .hockey: return "🏒"
        case .hunting: return "🏹"
        case .lacrosse: return "🥍"
        case .martialArts: return "🥋"
        case .mindAndBody: return "🧘‍♀️"
        case .mixedMetabolicCardioTraining: return "🏃‍♂️"
        case .paddleSports: return "🛶"
        case .play: return "🤾‍♂️"
        case .preparationAndRecovery: return "🍎"
        case .racquetball: return "🎾"
        case .rowing: return "🚣‍♀️"
        case .rugby: return "🏉"
        case .running: return "🏃‍♂️"
        case .sailing: return "⛵️"
        case .skatingSports: return "⛸"
        case .snowSports: return "🎿"
        case .soccer: return "⚽️"
        case .softball: return "🥎"
        case .squash: return "🎾"
        case .stairClimbing: return "🚶‍♀️"
        case .surfingSports: return "🏄‍♂️"
        case .swimming: return "🏊‍♀️"
        case .tableTennis: return "🏓"
        case .tennis: return "🎾"
        case .trackAndField: return "🏃‍♂️"
        case .traditionalStrengthTraining: return "💪"
        case .volleyball: return "🏐"
        case .walking: return "🚶‍♀️"
        case .waterFitness: return "🏊‍♀️"
        case .waterPolo: return "🤽‍♂️"
        case .waterSports: return "🚣‍♀️"
        case .wrestling: return "🤼‍♂️"
        case .yoga: return "🧘‍♀️"
        // Add more specific cases if needed
        default: return "🏋️‍♀️" // Generic emoji for other activities
        }
    }
}


