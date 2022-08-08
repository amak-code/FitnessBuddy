//
//  ForgotPasswordView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/4/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var emailText: String = ""
    @ObservedObject var signInViewModel: SignInViewModel
    @State private var alertText: String = "Test"
    
    
    var body: some View {
 
            VStack(alignment: .center, spacing: 50) {
                FormField(label: "E-mail", placeholder: "Enter your e-mail", input: $emailText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                NavigationLink(destination: SigninView(signInViewModel: signInViewModel), isActive: $signInViewModel.successReset){
                    Button {
                        guard !emailText.isEmpty else {
                            return}
                        
                        signInViewModel.forgotPassword(email: emailText)
                        
                        emailText = ""
                        
                    } label: {
                        ButtonLabel(text: "Send", colorName: "AccentDark", textColor: "LightText")
                    }
                    .alert(Text("Important message"), isPresented: $signInViewModel.showForgotPasswordAlert, actions: {
                        Button("OK", role: .cancel, action: {})
                    }, message: {
                        // let text = alertTextToPresent()
                        Text("Please try again. You entered invalid email.")
                    })
                    
                }//NavLink
                
                Spacer()
            }
            .padding(.top, 80)
            .navigationTitle("Forgot Password")
            .navigationBarBackButtonHidden(true)

    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(signInViewModel: SignInViewModel())
    }
}


