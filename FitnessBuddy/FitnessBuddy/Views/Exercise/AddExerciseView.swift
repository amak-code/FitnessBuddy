//
//  AddExerciseView.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/9/22.
//

import SwiftUI

struct AddExerciseView: View {
    let exercise: Exercise
    @ObservedObject var vm = AddExerciseViewModel()
    // TODO: choose workout list to add to
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 2) {
                //Text("Destination")
                TitleText(text: "Add to Workout")

                Text(exercise.name)
                Text("Sets: \(Int(vm.sets))")
                Slider(value: $vm.sets, in: 0...10, step: 1)
                Text("Reps: \(Int(vm.reps))")
                Slider(value: $vm.reps, in: 0...25, step: 1)
                // TODO: add var for kb or lb
                Text("Maximum Weight: \(Int(vm.weight)) \(vm.metric)")
                Slider(value: $vm.weight, in: 0...1_000, step: 2)
                ButtonLabel(text: "Save", colorName: "AccentDark", textColor: "LightText")
            }
            // .background(Color("LightBackground"))
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(exercise: Exercise(bodyPart: bodyParts.lowerlegs, equipment: "Dumbell", gifUrl: "eep.org", id: "0001", name: "Dumbell up", target: "Arm"))
    }
}
class AddExerciseViewModel: ObservableObject {
    @Published var ename: String = ""
    @Published var sets: Double = 5
    @Published var reps: Double = 10
    @Published var weight: Double = 0
    @Published var metric: String = "kg"
}
