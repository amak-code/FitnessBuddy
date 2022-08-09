//
//  SigninView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/4/22.
//

/* User sigh in account for the test:
 username: Em@gmail.com
 password: 1234567
 */


import SwiftUI

struct SigninView: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @ObservedObject var signInViewModel: SignInViewModel
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .center, spacing: 20) {
                
                FormField(label: "E-mail", placeholder: "Enter your e-mail", input: $emailText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                VStack(alignment: .leading) {
                    Text("Password")
                    SecureField("Enter your password", text: $passwordText)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground).cornerRadius(12))
                    
                    //MARK: - Forgot password
                    NavigationLink(destination: ForgotPasswordView(signInViewModel: signInViewModel)) {
                        Text("Forgot Password?")
                            .padding(.top)
                            .foregroundColor(Color("AccentDark"))
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                
                //MARK: - Sign in
                
                NavigationLink(destination: MenuView(), isActive: $signInViewModel.signedIn){
                    
                    Button {
                        guard !emailText.isEmpty, !passwordText.isEmpty else {
                            return}
                        signInViewModel.sighInUser(email: emailText, password: passwordText)
                        emailText = ""
                        passwordText = ""
          
                        
                    } label: {
                        ButtonLabel(text: "Sign In", colorName: "AccentLight", textColor: "LightText")
                    }
                }
                
                Text("--   Or   --")
                
                //MARK: - Sign Up
                
                NavigationLink {
                    SignupView(emailText: "", usernameText: "", passwordText: "")
                } label: {
                    ButtonLabel(text: "Create an Account", colorName: "LightBackground", textColor: "AccentDark")
                }
                
                Spacer()
                
                
                //MARK: -  Test for Sign Out Button
                Button {
                    
                    if signInViewModel.isSignedIn {
                        signInViewModel.signOut()
                    }

                } label: {
                    ButtonLabel(text: "Sign Out", colorName: "AccentLight", textColor: "LightText")
                }
            }
            .padding(.top, 60)
            .navigationTitle("Sign In")
            .navigationBarBackButtonHidden(true)
            
        }//Zstack
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView(signInViewModel: SignInViewModel())
    }
}
