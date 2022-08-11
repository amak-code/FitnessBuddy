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
            TitleText(text: exercise.name)
            Text(exercise.bodyPart.rawValue)
            Text(exercise.equipment)
            GifImage(exercise.gifUrl)
                .frame(width: UIScreen.screenWidth - 20, height: UIScreen.screenHeight/2 - 20, alignment: .center)
            Text(exercise.id)
            Text(exercise.target)
        }
        .toolbar {
            NavigationLink("Add to Workout") {
                AddExerciseView(exercise: exercise)
            }
        }
        .frame(width: UIScreen.screenWidth - 25, height: UIScreen.screenHeight - 50, alignment: .center)
        
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exercise: Exercise(bodyPart: bodyParts.lowerlegs, equipment: "squat rack", gifUrl: "gif placement", id: "id placement", name: "deadlift", target: "target muscle: "))
    }
}
