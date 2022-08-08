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
        NavigationView {
            VStack(alignment: .center, spacing: 50) {
                FormField(label: "E-mail", placeholder: "Enter your e-mail", input: $emailText)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Button {
                    guard !emailText.isEmpty else {
                        return}
                    
                    signInViewModel.forgotPassword(email: emailText)
                    emailText = ""
                    
                    if signInViewModel.successReset == true {
                        alertText = "Please go to your email account to set up a new password"
                    }else {
                        
                        alertText = "Please try again. You entered invalid email."
                    }
                    
                  
                } label: {
                    ButtonLabel(text: "Send", colorName: "AccentDark", textColor: "LightText")
                }
                .alert(Text("Important message"), isPresented: $signInViewModel.showForgotPasswordAlert, actions: {
                    Button("OK", role: .cancel, action: {})
                }, message: {
                    // let text = alertTextToPresent()
                    Text(alertText)
                })
                
                
                Spacer()
            }
            .padding(.top, 80)
            .navigationTitle("Forgot Password")
            //  .navigationBarBackButtonHidden(true)
        }
        
        
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(signInViewModel: SignInViewModel())
    }
}

//extension ForgotPasswordView {
//
//    func alertTextToPresent() -> String{
//
//        if signInViewModel.successReset == true {
//            alertText = "Please go to your email account to set up a new password"
//        }else {
//            alertText = "Please try again. You entered invalid email."
//        }
//      return alertText
//    }
//
//}
