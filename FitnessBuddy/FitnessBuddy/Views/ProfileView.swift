//
//  ProfileView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/5/22.
//

import SwiftUI

struct ProfileView: View {
    @State private var isNotified: Bool = true
    var body: some View {
        VStack {
            Spacer()
            Text("Hi, username!")
            Spacer()
            HStack(spacing: 20) {
                Text("Change unit")
                // TODO: Change from kg to lb
                Picker(selection: .constant(1), label: Text("Picker")) {
                    Text("lb").tag(1)
                    Text("kg").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                .padding(.vertical)
            }
            Spacer()
            
            Button {
                // TODO: Call logout function
            } label: {
                ButtonLabel(text: "Logout", colorName: "AccentLight", textColor: "LightText")
            }
            Spacer()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
