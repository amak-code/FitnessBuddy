//
//  Card.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/9/22.
//
import SwiftUI

struct Card: View {
    var text: String
    var imageName: String
    var height: CGFloat = UIScreen.screenHeight/4 - 25
    var width: CGFloat = UIScreen.screenWidth/2 - 25
    
    var body: some View {
        
        VStack {
            Text(text)
                .frame(width: width, height: 25, alignment: .topTrailing)
                .font(Font.custom("BarlowCondensed-ExtraBoldItalic", size: 20))
                .foregroundColor(.primary)
                .background(Color("AccentDark"))
                
                
        }
        .background(Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width*2, height: height*2))
        .opacity(1)
        
        .foregroundColor(Color("AccentDark"))
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

// to get the screen size
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
