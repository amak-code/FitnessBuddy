//
//  TitleText.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/10/22.
//

import SwiftUI

struct TitleText: View {
    
    var text: String
    var size: CGFloat = 30
    var textColor: String = "AccentColor"
    
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .foregroundColor(Color(textColor))
            .font(Font.custom("BarlowCondensed-ExtraBoldItalic", size: 30))
    }
}
