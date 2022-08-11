//
//  WorkoutList.swift
//  FitnessBuddy
//
//  Created by cecily li on 8/5/22.
//
import Foundation

struct WorkoutList: Identifiable, Codable, Equatable {
    var title: String
    var date: Date
    var timestamp: String
    var id = UUID()
    var exercises: [ExerciseInWorkout] = []
}


struct ExerciseInWorkout: Identifiable, Codable, Equatable {
    
    var id = UUID()
    var name: String
    var sets: String
    var reps: String
    var maxWeight: String
    var timestamp: String
    
}

