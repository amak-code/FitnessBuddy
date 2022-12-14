//
//  ExerciseListView.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/3/22.
//

import SwiftUI

struct ExerciseListView: View {
    var exercises: [Exercise]
    var body: some View {
        
        VStack{
            List {
                ForEach(exercises) { exercise in
                    NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                        HStack {
                            Image("dumbell_icon")
                                .resizable()
                                .frame(width: 23, height: 23, alignment: .leading)
                            Text("\(exercise.name)".capitalized)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Exercises")
    }
    
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView(exercises: [Exercise(bodyPart: bodyParts.lowerlegs, equipment: "squat rack", gifUrl: "gif placement", id: "id placement", name: "deadlift", target: "target muscle: ")])
    }
}

