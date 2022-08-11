//
//  ExerciseInWorkoutDetailView.swift
//  FitnessBuddy
//
//  Created by antikiller on 09.08.2022.
//

import SwiftUI

struct ExerciseInWorkoutDetailView: View {
    @State var exercisename: String = ""
    @State var numberofsets: String = ""
    @State var numberofreps: String = ""
    @State var maximumweight: String = ""
    @Environment(\.dismiss) private var dismiss
    @State var showAlert: Bool = false
    @State var alertExerciseName: String = ""
    @Environment(\.presentationMode) var presentationMode
    var listViewModel:WorkoutListViewModel
    var workoutlist: WorkoutList
    var exercise: ExerciseInWorkout
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Your exercise detail:")
                    .bold()
                    .foregroundColor(.green)
                    .font(.system(size: 30, design: .default))
                
                TextField(exercise.name, text: $exercisename).frame(height: 55)
                    .padding([.horizontal], 4)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                    .padding([.horizontal], 24)
                
                HStack {
                    Text("Number of sets:  ");
                    TextField(exercise.sets, text: $numberofsets)
                        .padding([.horizontal], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .padding([.horizontal], 24)}
                HStack {
                    Text("Number of reps:  ");
                    TextField(exercise.reps, text: $numberofreps)
                        .padding([.horizontal], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .padding([.horizontal], 24)}
                HStack {
                    Text("Maximum weight:");
                    TextField(exercise.maxWeight, text: $maximumweight)
                        .padding([.horizontal], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                        .padding([.horizontal], 24)
                }
                
            }.padding()
            
            Button(action: saveButtonPressed, label: {
                ButtonLabel(text: "Save", colorName: "AccentLight", textColor: "LightText")
            })
        }.alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if exercisename.isEmpty {
            alertExerciseName = "Please enter an exercise:"
            showAlert.toggle()
        } else {
            WorkoutListViewModel.uploadExerciseToDatabase(exercisename: exercisename, sets: numberofsets, reps: numberofreps, weight: maximumweight, workouttimestamp: workoutlist.timestamp, timestamp: exercise.timestamp)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertExerciseName))
    }
}
