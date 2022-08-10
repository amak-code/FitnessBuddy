//
//  Exercise.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/3/22.
//

import Foundation

struct Exercise: Identifiable, Decodable {
    let bodyPart: bodyParts
    let equipment: String
    let gifUrl: String
    let id: String
    let name: String
    let target: String
}

enum bodyParts: String, Decodable, CaseIterable{
    case back = "back"
    case cardio = "cardio"
    case chest = "chest"
    case lowerarms =  "lower arms"
    case lowerlegs = "lower legs"
    case neck = "neck"
    case shoulders = "shoulders"
    case upperarms = "upper arms"
    case upperlegs = "upper legs"
    case waist = "waist"
}

