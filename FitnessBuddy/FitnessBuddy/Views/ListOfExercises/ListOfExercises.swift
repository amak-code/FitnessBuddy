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
       // let withIndex = exercises.enumerated().map({ $0 })
        VStack{
            List {
                ForEach(Array(zip(1..., exercises)), id: \.1.id) {num, exercise in
                    NavigationLink {
                        ExerciseInWorkoutDetailView()
                    } label: {
                        ExerciseRow(exercise: exercise, num: num)
                    }
                }
            }
             
            }.navigationTitle("Workout Details")
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
        ListOfExercises(listViewModel: WorkoutListViewModel(), exercises: [ExerciseInWorkout(name: "Neck", sets: "10", reps: "2", maxWeight: "20"),ExerciseInWorkout(name: "Lower Back", sets: "12", reps: "45", maxWeight: "30")])
    }
}

struct ExerciseRow: View{
    var exercise: ExerciseInWorkout
    var num: Int
    var body: some View {
        VStack(alignment: .leading){
            Text("\(num). \(exercise.name)")
                HStack{
                    HStack {
                        Text("Sets: ")
                      
                        Text(" \(exercise.sets)")
                            .frame(width: 40, height: 30,  alignment: .center)
                            .background(.gray)
                            .multilineTextAlignment(.center)
                        
                    }
                    HStack{
                        Text("Reps: ")
                        Text(" \(exercise.reps)")
                            .frame(width: 30, height: 30, alignment: .center)
                            .background(.gray)
                        
                    }
                    HStack{
                        Text("Max Weight: ")
                            .lineLimit(1)
                        Text(" \(exercise.maxWeight)")
                            .frame(width: 30, height: 30, alignment: .center)
                            .background(.gray)
                    }
                }
        }
    }
}
