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
        NavigationView {
            VStack{
                List {
                    ForEach(exercises) { exercise in
                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                            Text(exercise.name)
                        }
                    }
                }
                
            }
            .onAppear{
            }
            .navigationTitle("Exercises")
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView(exercises: [Exercise(bodyPart: "bodypart: legs", equipment: "squat rack", gifUrl: "http://d205bpvrqc9yn1.cloudfront.net/0001.gif", id: "id placement", name: "deadlift", target: "target muscle: ")])
    }
}
