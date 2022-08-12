//
//  ExerciseCategoryListView.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/3/22.
//

import SwiftUI

struct ExerciseCategoryListView: View {
    @ObservedObject var evModel = ExerciseCategoryViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                TitleText(text: "Explore  Exercises")
                
                LazyVGrid(columns: columns, alignment: .center){
                    ForEach(evModel.categories, id: \.self) { category in
                        NavigationLink(destination: ExerciseListView(exercises: evModel.categoryExercises[category] ?? [])) {
                            
                            Card(text: category,
                                 imageName: category)
                        }
                    }
                    .padding()
                }
                
                if evModel.categoryExercises.isEmpty {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(Color("AccentDark"))
                            .scaleEffect(2)
                            .padding(.bottom)
                        Text("Loading exercises...")
                            .italic()
                            .font(.caption)
                            .foregroundColor(Color("AccentDark"))
                    }
                    .padding(.top, 150)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExerciseCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCategoryListView()
            .previewDisplayName("iPhone 11")
    }
}

class ExerciseCategoryViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var categoryExercises: [String : [Exercise] ] = [:]
    @Published var categories: [String] = []
    
    init() {
        DispatchQueue.main.async {
            self.getAllExercises()
        }
        
    }

    func getAllExercises() {
        
        ExerciseDBController.fetchExercises() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let exercises):
                    self.exercises = exercises
                    self.getExercisesBy()
                case .failure(let error):
                    print("There was an error with call to fetchExercises(): \(error.localizedDescription) -> \(error)")
                }
            }
        }
    }
    func getExercisesBy() {
        for bpart in bodyParts.allCases {
            
            self.categories.append(bpart.rawValue)
            let filtered = self.exercises.filter{ exercise in
                return exercise.bodyPart.rawValue == bpart.rawValue }
            self.categoryExercises[bpart.rawValue] = filtered
        }
    }
    
    
}

