//
//  SignupView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/4/22.
//

import SwiftUI

struct SignupView: View {
    
    @State private var emailText: String = ""
    @State private var usernameText: String = ""
    @State private var passwordText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                
                FormField(label: "Username", placeholder: "Enter your username", input: usernameText)
                
                FormField(label: "E-mail", placeholder: "Enter your e-mail", input: emailText)
                
                FormField(label: "Password", placeholder: "Create a password", input: passwordText)
                Spacer()
                Button {
                    // TODO: Call sign up function
                } label: {
                    ButtonLabel(text: "Sign Up", colorName: "AccentLight", textColor: "LightText")
                }
                
                Text("--   Or   --")
                //TODO: This button should just lead user to signin view
                ButtonLabel(text: "Sign In Here", colorName: "LightBackground", textColor: "AccentDark")
                Spacer()
            }
            .padding(.top, 40)
            .navigationTitle("Sign Up")
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
