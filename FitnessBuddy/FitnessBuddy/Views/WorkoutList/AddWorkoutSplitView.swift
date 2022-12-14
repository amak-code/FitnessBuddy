//
//  AddWorkoutSplitView.swift
//  FitnessBuddy
//
//  Created by cecily li on 8/5/22.
//
import SwiftUI

struct AddWorkoutSplitView: View {

    var split: WorkoutList?
    @State var title: String = ""
    @State var WorkoutDate = Date()
    @Environment(\.dismiss) private var dismiss
    var listViewModel:WorkoutListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    @Binding var showingPopup: Bool

    var body: some View {

        ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text("Add new workout:")
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

                    TextField("Enter workout name", text: $title)

                    DatePicker(selection: $WorkoutDate, displayedComponents: .date) {
                        Text("Select a date")}
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxHeight: .infinity)
                }.padding()
            
            Button(action: saveButtonPressed, label: {
                ButtonLabel(text: "Save", colorName: "AccentLight", textColor: "LightText")
            })
        }.alert(isPresented: $showAlert, content: getAlert)
    }

    func saveButtonPressed() {
        if title.isEmpty {
            alertTitle = "Please enter a workout:"
            showAlert.toggle()
        } else {
            let timestamp = String(Int(NSDate().timeIntervalSince1970))
            WorkoutListViewModel.uploadEntryToDatabase(title: title, date: WorkoutListViewModel.dateToString(date: WorkoutDate), timestamp: timestamp)
            presentationMode.wrappedValue.dismiss()
            showingPopup = false
        }
    }

    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}
