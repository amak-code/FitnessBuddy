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
}
