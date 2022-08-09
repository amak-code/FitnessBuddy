//
//  SignInViewModel.swift
//  FitnessBuddy
//
//  Created by antikiller on 04.08.2022.
//

import UIKit
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class SignInViewModel: ObservableObject {
    
    @Published var signedIn = false
    @Published var successReset: Bool = false
    @Published var showForgotPasswordAlert: Bool = false
    @Published var showSignUpAlert: Bool = false
    @Published var alertText: String = ""
    @Published var rightSignUp: Bool = false
    
     var isSignedIn: Bool {
        let auth = Auth.auth()
        return auth.currentUser != nil
    }
    //SIGN IN
    func sighInUser(email: String, password: String) {
        let defaults = UserDefaults.standard
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) {(authResult, error) in
          guard authResult != nil, error == nil else{
               
                return
            }
            DispatchQueue.main.async {
                self.signedIn = true
            }
            
            //test for sign in
            if auth.currentUser != nil {
                
                print("SIGNED IN!!!!")
            }
        }
    }
    
    //SIGN UP
    func signUpUser(email: String, password: String, name: String) {
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password) {(authResult, error) in
            
            if error != nil {
                self.showSignUpAlert = true
                print(error ?? "There was an error while SIGNING UP")
                
                return
            }
            self.uploadNewUserToDatabase(email: email, name: name)
            
            DispatchQueue.main.async {
                print("SIGNED UP!")
                self.rightSignUp = true
                self.signedIn = true
            }
        }
    }
    
    
    //FORGOT PASSWORD
    func forgotPassword(email: String) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: email) { (error) in
           
            if  error != nil {
                self.showForgotPasswordAlert = true
              //  self.alertText = "Please try again. You entered invalid email."
                print(error ?? "There was an error while request was submitted")
                
                return
            }
            
            DispatchQueue.main.async {
                
              self.successReset = true
                print("YOU WILL RECEIVE AN EMAIL TO RESET THE PASSWORD!!!")
              //  self.alertText = "Please go to your email account to set up a new password"
                
            }
            
        }
    }
    
    
    func signOut(){
        let auth = Auth.auth()
        try? auth.signOut()
        
        self.signedIn = false
        
        if auth.currentUser == nil {
            
            print("SIGNED OUT!!!!")
        }
        
    }
    
    //UPLOAD USER TO THE DATABASE
    func uploadNewUserToDatabase(email: String, name: String) {
        let rootref = Database.database().reference()
        let ref = rootref.child("users")
        let uid = Auth.auth().currentUser?.uid
        ref.child(uid!).setValue(["email":email, "name":name, "entries": ""])
    }
    

    //ALERT CONTROLLER
//    func createAlertController(title:  String, message: String) -> UIAlertController {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            alert.dismiss(animated: true, completion: nil)
//        }
//        alert.addAction(okAction)
//        return alert
//    }
    
    
   
    
    static func formattedDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.string(from: date)
    }
    
    
}
