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
    var workoutlist: WorkoutList
    var exercises: [ExerciseInWorkout]
    var body: some View {
        // let withIndex = exercises.enumerated().map({ $0 })
        ZStack {
            if showingPopup {
                addExerciseView(showingPopup: $showingPopup, listViewModel: WorkoutListViewModel(), workoutlist: workoutlist)
            } else {
                VStack{
                    if listViewModel.exercises.isEmpty {
                        NoExerciseView(showingPopup: $showingPopup, workoutlist: workoutlist)
                            .transition(AnyTransition.opacity.animation(.easeIn))
                    } else {
                        List {
                            ForEach(Array(zip(1..., listViewModel.exercises)), id: \.1.id) { num, exercise in
                                NavigationLink {
                                    ExerciseInWorkoutDetailView(listViewModel: WorkoutListViewModel(), workoutlist: workoutlist, exercise: exercise)
                                                    } label: {
                                                        ExerciseRow(exercise: exercise, num: String(num))
                                                    }
                            }.onDelete(perform: deleteexercise(indexSet:))
                        }
                    }
                }.navigationTitle("Workout Details")
                // .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button {
                            showingPopup = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
            }
        }.onAppear{listViewModel.getExerciseEntries(workouttimestamp: workoutlist.timestamp)}
    }
    func deleteexercise(indexSet: IndexSet) {
        var index: Int = 0
        for idx in indexSet {
            index = idx
        }
        listViewModel.deleteExerciseEntryFromDatabase(index: index, workouttimestamp: workoutlist.timestamp)
    }
}

struct ListOfExercises_Previews: PreviewProvider {
    static var previews: some View {
        ListOfExercises(listViewModel: WorkoutListViewModel(), workoutlist:
                            WorkoutList(title: "test", date: Date(), timestamp: "1234567890"), exercises: [ExerciseInWorkout(name: "Neck", sets: "10", reps: "2", maxWeight: "20", timestamp: "1234567890"),ExerciseInWorkout(name: "Lower Back", sets: "12", reps: "45", maxWeight: "30", timestamp: "0987654321")])
    }
}

struct ExerciseRow: View{
    var exercise: ExerciseInWorkout
    var num: String
    
    var body: some View {
        VStack(alignment: .leading){
                Text("\(num). \(exercise.name)")
                    .bold()
                    .font(.system(size: 20))
                HStack {
                    HStack {
                        Text("Sets: ")
                        Text("\(exercise.sets)")
                            .frame(width: 30, height: 30, alignment: .center)
                            .background(Color("UnselectedTabColor"))
                            .multilineTextAlignment(.center)
                    }
                    
                    HStack {
                        Text("Reps: ")
                        Text("\(exercise.reps)")
                            .frame(width: 30, height: 30, alignment: .center)
                            .background(Color("UnselectedTabColor"))
                            .multilineTextAlignment(.center)
                    }
                    
                    HStack {
                        Text("Weight: ")
                        Text("\(exercise.maxWeight)")
                            .frame(width: 30, height: 30, alignment: .center)
                            .background(Color("UnselectedTabColor"))
                            .multilineTextAlignment(.center)
                    }
                }
        }
    }
}
