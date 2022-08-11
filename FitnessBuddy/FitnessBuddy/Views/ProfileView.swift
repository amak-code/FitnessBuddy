//
//  ProfileView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/5/22.
//

import SwiftUI

struct ProfileView: View {
    @State private var isNotified: Bool = true
    @State var name = ""
    @State var showSigninView = false
    @ObservedObject var signInVM: SignInViewModel
    @ObservedObject var listViewModel: WorkoutListViewModel
    var body: some View {
        VStack {
            TitleText(text: "Profile")
            Spacer()
            Text("Hi, \(name)!")
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
            
            NavigationLink(destination: SigninView(signInViewModel:signInVM), isActive:$showSigninView){
                Button {
                        signInVM.signOut()
                        self.showSigninView = true
                } label: {
                    ButtonLabel(text: "Sign Out", colorName: "AccentLight", textColor: "LightText")
                }
            }
            Spacer()
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
           // getUser()
            DispatchQueue.main.async {
                getUser()
            }
        }
    }
    func getUser() {
            let defaults = UserDefaults.standard
            listViewModel.getUserInfo()
           name = defaults.string(forKey: "userNameKey") ?? ""
    }
}
