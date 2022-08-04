//
//  Button.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/4/22.
//

import SwiftUI

struct ButtonLabel: View {
    
    var text: String
    var colorName: String
    var textColor: String
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .foregroundColor(Color(textColor))
            .frame(width: 300, height: 50)
            .background(Color(colorName))
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
