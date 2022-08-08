//
//  MenuView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/3/22.
//

import SwiftUI

struct MenuView: View {
    
    @State private var selection = 1
    
    init() {
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
            Text("There will be a list of workouts")
                .tabItem {
                    Label("My Workouts", systemImage: "figure.walk.circle.fill")
                }
                .tag(3)
            Text("There will be a music tab")
                .tabItem {
                    Label("Player", systemImage: "play.fill")
                }
                .tag(4)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(5)
        }
        .accentColor(Color("AccentLight"))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
