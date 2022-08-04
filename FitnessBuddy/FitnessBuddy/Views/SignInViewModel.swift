//
//  SignInViewModel.swift
//  FitnessBuddy
//
//  Created by antikiller on 04.08.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class SignInViewModel: ObservableObject {
    
    //SIGN IN
    static func sighInUser(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let defaults = UserDefaults.standard
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) {(authResult, error) in
            if error != nil {
                onError(error)
                return
            }
    }
    }
    
    //SIGN OUT
    static func signUpUser(email: String, password: String, name: String, onSuccess: @escaping() -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password) {(authResult, error) in
            if error != nil {
                onError(error)
                return
            }
            uploadNewUserToDatabase(email: email, name: name, onSuccess: onSuccess)
        }
    }
    
    
    //FORGOT PASSWORD
    static func forgotPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                let alert = createAlertController(title: "Error", message: error.localizedDescription)
                alert.present(alert, animated: true, completion: nil)
                return
            }
            let alert = createAlertController(title: "Hurray", message: "A password reset email has been sent!")
            alert.present(alert, animated: true, completion: nil)
        }
    }

    
    //UPLOAD USER TO THE DATABASE
    static func uploadNewUserToDatabase(email: String, name: String, onSuccess: @escaping() -> Void) {
        let rootref = Database.database().reference()
        let ref = rootref.child("users")
        let uid = Auth.auth().currentUser?.uid
        ref.child(uid!).setValue(["email":email, "name":name, "entries": ""])
        onSuccess()
    }
    

    //ALERT CONTROLLER
    static func createAlertController(title:  String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        return alert
    }
    
    
   
    
    static func formattedDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.string(from: date)
    }
    
    
}
