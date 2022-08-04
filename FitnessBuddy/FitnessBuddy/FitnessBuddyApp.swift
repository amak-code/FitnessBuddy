//
//  FitnessBuddyApp.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/3/22.
//

import SwiftUI

@main
struct FitnessBuddyApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: Check if user is signed in or not. If not - show sign in/signup screen
            MenuView()
        }
    }
}
