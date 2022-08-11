//
//  WorkoutListView.swift
//  FitnessBuddy
//
//  Created by cecily li on 8/5/22.
//
import SwiftUI

struct WorkoutListView: View {

    @ObservedObject var listViewModel: WorkoutListViewModel
    @State var showingPopup = false

    var body: some View {
        VStack {
            ZStack {
                if showingPopup {
                    AddWorkoutSplitView(listViewModel: WorkoutListViewModel(), showingPopup: $showingPopup)
                } else {
            ScrollView {
                TitleText(text: "My Workouts")
                VStack {
                    if listViewModel.WorkoutLists.isEmpty {
                        NoEntryView(showingPopup: $showingPopup)
                        .transition(AnyTransition.opacity.animation(.easeIn))
                    } else {
                        List {
                            ForEach(listViewModel.WorkoutLists) { list in
                                ListRowView(list: list)

                        }.onDelete(perform: listViewModel.deleteEntryFromDatebase(indexSet:))
                             //.padding()
                    }
                        .frame(height: CGFloat(listViewModel.WorkoutLists.count) * 115 + 25)
                        .listStyle(.plain)
                    }
                    //}
                }
                .navigationTitle("My workout splits")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        showingPopup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            listViewModel.getEntries()
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutListView(listViewModel: WorkoutListViewModel())
        }
    }
}


struct ListRowView: View {
    @ObservedObject var viewModel = WorkoutListViewModel()
    @State var list: WorkoutList
    var body: some View {
        VStack {
            NavigationLink(destination: ListOfExercises(listViewModel: viewModel, workoutlist: list, exercises: list.exercises)){
            Text(list.title)
            }
        }
    }
}
