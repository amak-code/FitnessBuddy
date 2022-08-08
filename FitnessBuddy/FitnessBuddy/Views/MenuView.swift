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
        //UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "UnselectedTabColor")
      }
    
    var body: some View {
        TabView(selection:$selection) {
            Text("There will be a Home Page")
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(1)
            Text("There will be a Health Tab")
                .tabItem {
                    Label("Health", systemImage: "bolt.heart.fill")
//                    Label("Health", systemImage: "waveform.path.ecg.rectangle.fill")
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
            Text("There will be a profile tab")
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
