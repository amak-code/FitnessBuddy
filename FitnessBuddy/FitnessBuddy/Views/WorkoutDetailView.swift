//
//  WorkoutDetailView.swift
//  FitnessBuddy
//
//  Created by cecily li on 8/7/22.
//

import SwiftUI

struct WorkoutDetailView: View {
    
    var split: WorkoutList?
    @State var title: String = ""
    @State var WorkoutDate = Date()
    @Environment(\.dismiss) private var dismiss
    var listViewModel:WorkoutListViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    var list: WorkoutList

    var body: some View {
        
        ScrollView {
        
//        VStack {
//            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading) {
                    Text("Workout Detail:")
                        .bold()
                        .foregroundColor(.green)
                        .font(.system(size: 30, design: .default))
                        
                    TextField(list.title, text: $title)
                    
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
            WorkoutListViewModel.uploadEntryToDatabase(title: title, date: WorkoutListViewModel.dateToString(date: WorkoutDate), timestamp: list.timestamp)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutDetailView(listViewModel: WorkoutListViewModel(), list: WorkoutList(title: "test", date: Date(), timestamp: "1234567890"))
        }
    }
}
