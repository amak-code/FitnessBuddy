//
//  FitnessBuddyApp.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/3/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FitnessBuddyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            // TODO: Check if user is signed in or not. If not - show sign in/signup screen, if yes - show MenuView
            SignupView()
        }
    }
}
