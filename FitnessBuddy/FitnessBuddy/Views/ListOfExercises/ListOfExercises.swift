//
//  ListOfExercises.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/8/22.
//

import SwiftUI

struct ListOfExercises: View {
    
    @ObservedObject var listViewModel: WorkoutListViewModel
    @State var showingPopup = false
    var exercises: [ExerciseInWorkout]
    var body: some View {
        VStack{
            List {
                ForEach(exercises) {exercise in
                    NavigationLink {
                        ExerciseInWorkoutDetailView()
                    } label: {
                        ExerciseRow(exercise: exercise)
                    }
                }
            }
             
            }.navigationTitle("Exercises")
           // .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                   ExerciseInWorkoutDetailView()
                } label: {
                    Image(systemName: "plus")
                }
                    }
    }
}

struct ListOfExercises_Previews: PreviewProvider {
    static var previews: some View {
        ListOfExercises(listViewModel: WorkoutListViewModel(), exercises: [ExerciseInWorkout(name: "Neck", sets: 10, reps: 2, maxWeight: 20),ExerciseInWorkout(name: "Lower Back", sets: 12, reps: 45, maxWeight: 30)])
    }
}

struct ExerciseRow: View{
    var exercise: ExerciseInWorkout
    var body: some View {
        VStack{
            Text(exercise.name)
                HStack{
                    Text("Sets: \(exercise.sets)")
                    Text("Reps: \(exercise.reps)")
                    Text("Max Weight: \(exercise.maxWeight)")
                }
        }
    }
}
