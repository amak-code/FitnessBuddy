//
//  SigninView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/4/22.
//

import SwiftUI

struct SigninView: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @ObservedObject var signInViewModel: SignInViewModel
    @State private var loggedIn = false
    
    var body: some View {
            VStack(alignment: .center, spacing: 20) {
                
                FormField(label: "E-mail", placeholder: "Enter your e-mail", input: $emailText)
                
                VStack(alignment: .leading) {
                    Text("Password")
                    SecureField("Enter your password", text: $passwordText)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground).cornerRadius(12))
                    Text("Forgot Password?")
                        .padding(.top)
                        .foregroundColor(Color("AccentDark"))
                        
                }
                .padding(.horizontal, 30)
                
                Spacer()
                Button {
                    // TODO: Call sign in function
                    guard !emailText.isEmpty, !passwordText.isEmpty else {
                        return}
                    signInViewModel.sighInUser(email: emailText, password: passwordText)
                } label: {
                    ButtonLabel(text: "Sign In", colorName: "AccentLight", textColor: "LightText")
                }
                
                Text("--   Or   --")
                
                NavigationLink {
                    SignupView(emailText: "", usernameText: "", passwordText: "")
                } label: {
                    ButtonLabel(text: "Create an Account", colorName: "LightBackground", textColor: "AccentDark")
                }
                
                Spacer()
            }
            .padding(.top, 60)
            .navigationTitle("Sign In")
            .navigationBarBackButtonHidden(true)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView(signInViewModel: SignInViewModel())
    }
}
