//
//  MenuView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/3/22.
//

import SwiftUI

struct MenuView: View {
    
    @State private var selection = 1
    //@ObservedObject var signInVM: SignInViewModel
    
    init() {
        //self.signInVM = signInModel
        UITabBar.appearance().backgroundColor = UIColor(named: "AccentDark")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "UnselectedTabColor")
      }
    
    var body: some View {
        TabView(selection:$selection) {
            ExerciseCategoryListView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(1)
            HealthView()
                .tabItem {
                    Label("Health", systemImage: "bolt.heart.fill")
                }
                .tag(2)
            WorkoutListView(listViewModel: WorkoutListViewModel())
                .tabItem {
                    Label("My Workouts", systemImage: "figure.walk.circle.fill")
                }
                .tag(3)
            Text("There will be a music tab")
                .tabItem {
                    Label("Player", systemImage: "play.fill")
                }
                .tag(4)
            ProfileView(signInVM: SignInViewModel(), listViewModel: WorkoutListViewModel())
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(5)
        }
        .accentColor(Color("AccentLight"))
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
