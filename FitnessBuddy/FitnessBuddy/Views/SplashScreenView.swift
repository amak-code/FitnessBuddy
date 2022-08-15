//
//  SplashScreenView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/4/22.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State var userSignedIn: Bool = true
    @ObservedObject var signInViewModel = SignInViewModel()
    
    var body: some View {
        if isActive {
            if userSignedIn {
                MenuView()
            }
            else {
                SignupView(signInVM: signInViewModel, emailText: "", usernameText: "", passwordText: "")
            }
        } else {
            VStack {
                Text("FitnessBuddy")
                    .font(Font.custom("BarlowCondensed-ExtraBoldItalic", size: 60))
                    .foregroundColor(Color("AccentDark").opacity(0.80))
                    .shadow(color: Color("AccentLight"), radius: 10, x: 5, y: 5)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                Spacer()
            }
            .background(Image("launchBackground"))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                        
                        //MARK: - if you comment out below line you will be able to test sign in and sign up view even if you signed in before
                        self.userSignedIn = signInViewModel.isSignedIn
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(signInViewModel: SignInViewModel())
    }
}
