//
//  SignupView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/4/22.
//

import SwiftUI

struct SignupView: View {
    
    @ObservedObject var signInVM = SignInViewModel()
    @State var showMainView = false
    @State var emailText: String
    @State var usernameText: String
    @State var passwordText: String
    
    var body: some View {
            VStack(alignment: .center, spacing: 20) {
                
                FormField(label: "Username", placeholder: "Enter your username", input: $usernameText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                FormField(label: "E-mail", placeholder: "Enter your e-mail", input: $emailText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                FormField(label: "Password", placeholder: "Create a password", input: $passwordText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Spacer()
                
                NavigationLink(destination: MenuView(), isActive: $showMainView){
                    
                    Button {
                        guard !emailText.isEmpty, !passwordText.isEmpty, !usernameText.isEmpty else {
                            return}
                        signInVM.signUpUser(email: emailText, password: passwordText, name: usernameText)
                        emailText = ""
                        passwordText = ""
                        usernameText = ""
                        self.showMainView = true

                    } label: {
                        ButtonLabel(text: "Sign Up", colorName: "AccentLight", textColor: "LightText")
                    }
                    
                }
              
                Text("--   Or   --")
                
                NavigationLink {
                    SigninView(signInViewModel: signInVM)
                } label: {
                    ButtonLabel(text: "Sign In Here", colorName: "LightBackground", textColor: "AccentDark")
                }
                
                Spacer()
            }
            .padding(.top, 40)
            .navigationTitle("Sign Up")
            .navigationBarBackButtonHidden(true)
        }
}
