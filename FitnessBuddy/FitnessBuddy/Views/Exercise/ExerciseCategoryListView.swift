//
//  ExerciseCategoryListView.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/3/22.
//

import SwiftUI

struct ExerciseCategoryListView: View {
    @ObservedObject var evModel = ExerciseCategoryViewModel()
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(evModel.categories, id: \.self) { category in
                        NavigationLink(destination: ExerciseListView(exercises: evModel.categoryExercises[category] ?? [])) {
                            Text(category)
                        }
                    }
                }
                .listStyle(.plain)
                
            }
            .onAppear{
                evModel.getExercises()
            }
            .navigationTitle("By Body Parts")
        }
        
    }
    
}

struct ExerciseCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCategoryListView()
    }
}

class ExerciseCategoryViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var categoryExercises: [String : [Exercise] ] = [:]
    @Published var categories: [String] = []
    func getExercises() {
        for bpart in bodyParts.allCases {
            ExerciseDBController.fetchExercises(by: bpart) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let exercises):
                        self.exercises = exercises
                        self.categoryExercises[bpart.rawValue] = self.exercises
                        self.categories.append(bpart.rawValue)
                    case .failure(let error):
                        print("There was an error with call to fetchExercises(): \(error.localizedDescription) -> \(error)")
                    }
                }
            }
        }
    }
    
}
