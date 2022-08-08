//
//  WorkoutListView.swift
//  FitnessBuddy
//
//  Created by cecily li on 8/5/22.
//
import SwiftUI

struct WorkoutListView: View {

    @ObservedObject var listViewModel: WorkoutListViewModel

    var body: some View {
        ScrollView {
            VStack {
                if listViewModel.WorkoutLists.isEmpty {
                    NoEntryView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    List {
                        ForEach(listViewModel.WorkoutLists) { list in ListRowView(list: list)

                    }.onDelete(perform: listViewModel.deleteEntryFromDatebase(indexSet:))
                         //.padding()
                }
                    .frame(height: CGFloat(listViewModel.WorkoutLists.count) * 115 + 25)
                    .listStyle(.plain)
                }
                //}
            }
            .navigationTitle("My workout splits")
            .edgesIgnoringSafeArea(.top)
            .navigationBarItems(
                trailing:
                    NavigationLink("Add", destination: AddWorkoutSplitView( listViewModel: WorkoutListViewModel()))
            )
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
            NavigationLink(destination: WorkoutDetailView(listViewModel: WorkoutListViewModel(), list:list)){
            Text(list.title)
            }
        }
    }
}
