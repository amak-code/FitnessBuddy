//
//  SplashScreenView.swift
//  FitnessBuddy
//
//  Created by cecily li on 8/4/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            MenuView()
        } else {
            ZStack {
//                VStack {
                    Image("launchBackground")
                VStack(alignment: .leading) {
                    Text("FitnessBuddy")
                        .font(Font.custom("Barlow Condensed", size: 60))
                        .foregroundColor(.green.opacity(0.80))
                        .accessibility(addTraits: .isHeader)
                        .padding(.top)
                }
                
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
