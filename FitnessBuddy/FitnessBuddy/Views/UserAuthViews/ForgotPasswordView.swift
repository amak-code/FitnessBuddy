//
//  ForgotPasswordView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/4/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var emailText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 50) {
                FormField(label: "E-mail", placeholder: "Enter your e-mail", input: emailText)
                
                ButtonLabel(text: "Send", colorName: "AccentDark", textColor: "LightText")
                Spacer()
            }
            .padding(.top, 80)
            .navigationTitle("Forgot Password")
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
