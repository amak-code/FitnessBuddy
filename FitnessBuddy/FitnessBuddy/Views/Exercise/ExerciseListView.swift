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
                TitleText(text: "Exercises")
                    .padding()
                List {
                    ForEach(exercises) { exercise in
                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                            HStack {
                                Image("dumbell_icon")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .leading)
                                Text(exercise.name)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView(exercises: [Exercise(bodyPart: bodyParts.lowerlegs, equipment: "squat rack", gifUrl: "gif placement", id: "id placement", name: "deadlift", target: "target muscle: ")])
    }
}

