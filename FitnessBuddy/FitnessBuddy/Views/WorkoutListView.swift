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
                    //                GeometryReader { proxy in
                    //                    VStack{
                    //                        Spacer().frame(height:
                    //                                        proxy.size.height * 0.05)
                    //                        Text("My workout splits")
                    //                            .font(.system(size: 20, weight: .bold))
                    //                            .foregroundColor(.green)
                    //                        Spacer()
                    //                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
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
                //leading: EditButton(),
                trailing:
                    NavigationLink("Add", destination: AddWorkoutSplitView( listViewModel: WorkoutListViewModel()))
            )
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutListView(listViewModel: WorkoutListViewModel())
        }
        //.environmentObject(WorkoutListViewModel())
    }
}


struct ListRowView: View {
    @ObservedObject var viewModel = WorkoutListViewModel()
    @State var list: WorkoutList
    var body: some View {
        VStack {
            NavigationLink(destination: WorkoutDetailView(listViewModel: WorkoutListViewModel(), list:list)){
            Text(list.title)
            //Text(WorkoutListViewModel.dateToString(date: list.date))
            }
        }
    }
}

