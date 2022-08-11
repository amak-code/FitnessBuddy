//
//  addExerciseView.swift
//  FitnessBuddy
//
//  Created by cecily li on 8/9/22.
//

import SwiftUI

struct addExerciseView: View {
    @State var exercisename: String = ""
    @State var numberofsets: String = ""
    @State var numberofreps: String = ""
    @State var maximumweight: String = ""
    @Environment(\.dismiss) private var dismiss
    @Binding var showingPopup: Bool
    @State var showAlert: Bool = false
    @State var alertExerciseName: String = ""
    @Environment(\.presentationMode) var presentationMode
    var listViewModel:WorkoutListViewModel
    var workoutlist: WorkoutList
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("Add new exercise:")
                        .bold()
                        .foregroundColor(.green)
                        .font(.system(size: 30, design: .default))
                    
                    Spacer()
                    
                    Button {
                        showingPopup = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                    }
                }
                TextField("Enter exercise name", text: $exercisename).frame(height: 55)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.horizontal], 4)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                    .padding([.horizontal], 24)
                
                HStack(alignment: .center) {
                    Text("Number of sets:");  TextField("Enter number of sets", text: $numberofsets).textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                    .padding([.horizontal], 24)}
                HStack(alignment: .center) {
                    Text("Number of reps:");  TextField("Enter number of reps", text: $numberofreps).textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray))
                    .padding([.horizontal], 24)}
                HStack(alignment: .center) {
                    Text("Maximum weight:");  TextField("Enter maximum weight", text: $maximumweight).textFieldStyle(PlainTextFieldStyle())
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
            let timestamp = String(Int(NSDate().timeIntervalSince1970))
            WorkoutListViewModel.uploadExerciseToDatabase(exercisename: exercisename, sets: numberofsets, reps: numberofreps, weight: maximumweight, workouttimestamp: workoutlist.timestamp, timestamp: timestamp)
            presentationMode.wrappedValue.dismiss()
            showingPopup = false
        }
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertExerciseName))
    }
}

