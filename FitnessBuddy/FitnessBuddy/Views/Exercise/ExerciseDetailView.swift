//
//  ExerciseDetailView.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/3/22.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    var body: some View {
        VStack{
            Text(exercise.name)
            Text(exercise.bodyPart)
            Text(exercise.equipment)
            Text(exercise.gifUrl)
            
            Text(exercise.id)
            Text(exercise.target)
        }
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exercise: Exercise(bodyPart: "bodypart: legs", equipment: "squat rack", gifUrl: "gif placement", id: "id placement", name: "deadlift", target: "target muscle: "))
    }
}
