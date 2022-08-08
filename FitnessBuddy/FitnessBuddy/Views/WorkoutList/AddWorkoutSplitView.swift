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

    var body: some View {

        ScrollView {

                VStack(alignment: .leading) {
                    Text("Add new workout:")
                        .bold()
                        .foregroundColor(.green)
                        .font(.system(size: 30, design: .default))

                    TextField("Enter workout name", text: $title)

                    DatePicker(selection: $WorkoutDate, displayedComponents: .date) {
                        Text("Select a date")}
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxHeight: .infinity)
                }.padding()

            Button(action: saveButtonPressed, label: {
                Text("Save".uppercased())
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 40)
                    .frame(maxWidth: 120)
                    .background(Color.accentColor)
                    .cornerRadius(10)
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
        }
    }

    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddWorkoutSplitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddWorkoutSplitView(listViewModel: WorkoutListViewModel())
        }
    }
}
