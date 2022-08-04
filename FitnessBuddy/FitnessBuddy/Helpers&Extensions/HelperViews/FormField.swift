//
//  FormField.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/4/22.
//

import SwiftUI

struct FormField: View {
    
    var label: String
    var placeholder: String
    @State var input: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            TextField(placeholder, text: $input)
                .padding()
                .background(Color(UIColor.secondarySystemBackground).cornerRadius(12))
                
        }
        .padding(.horizontal, 30)
    }
}
