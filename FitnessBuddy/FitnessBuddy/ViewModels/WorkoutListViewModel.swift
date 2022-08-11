//
//  WorkoutListViewModel.swift
//  FitnessBuddy
//
//  Created by cecily li on 8/5/22.
//
import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class WorkoutListViewModel: ObservableObject {

    @Published var WorkoutLists: [WorkoutList] = []
    @Published var exercises: [ExerciseInWorkout] = []
    init() {
        getEntries()
    }

    public func getUserInfo(){
        let ref = Database.database().reference()
        let defaults = UserDefaults.standard
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        ref.child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let email = dictionary["email"] as? String  == nil ? "email_not_found" : (dictionary["email"] as? String)
                let name = dictionary["name"] as? String == nil ? "name_not_found" : dictionary["name"] as? String
                defaults.set(email, forKey: "userEmailKey")
                defaults.set(name, forKey: "userNameKey")
            }
        })
    }

    public func getEntries(){
        let ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        ref.child("users").child(uid).child("entries").observe(.value, with: { (snapshot) in
            self.WorkoutLists = []
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                let userdict = userSnap.value as? NSDictionary
                let formatteddate = WorkoutListViewModel.stringToDate(date: userdict?.value(forKey: "date") as! String)
                let worklist = WorkoutList(title: userdict?.value(forKey: "title") as! String, date: formatteddate, timestamp: userSnap.key)
                self.WorkoutLists.append(worklist)
            }
        })
    }
    
    public func getExerciseEntries(workouttimestamp: String){
        let ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        ref.child("users").child(uid).child("entries").child(workouttimestamp).child("exercises").observe(.value, with: { (snapshot) in
            self.exercises = []
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                let userdict = userSnap.value as? NSDictionary
                let exercise = ExerciseInWorkout(name: userdict?.value(forKey: "exercisename") as! String, sets: userdict?.value(forKey: "sets") as! String, reps: userdict?.value(forKey: "reps") as! String, maxWeight: userdict?.value(forKey: "weight") as! String, timestamp: userSnap.key)
                self.exercises.append(exercise)
            }
        })
    }

    static func uploadEntryToDatabase(title: String, date: String, timestamp: String) {
        let rootref = Database.database().reference()
        let ref = rootref.child("users")
        let uid = Auth.auth().currentUser?.uid
        ref.child(uid!).child("entries").updateChildValues([timestamp: [
            "title": title,
            "date": date
        ]])
    }
    
    static func uploadExerciseToDatabase(exercisename: String, sets: String, reps: String, weight: String, workouttimestamp: String, timestamp: String) {
        let rootref = Database.database().reference()
        let ref = rootref.child("users")
        let uid = Auth.auth().currentUser?.uid
        ref.child(uid!).child("entries").child(workouttimestamp).child("exercises").updateChildValues([timestamp: [
            "exercisename": exercisename,
            "sets": sets,
            "reps": reps,
            "weight": weight
        ]])
    }

    func deleteEntryFromDatebase(indexSet: IndexSet) {
        var timestamp = ""
        for idx in indexSet {
            timestamp = WorkoutLists[idx].timestamp
        }
        let rootref = Database.database().reference()
        let ref = rootref.child("users")
        let uid = Auth.auth().currentUser?.uid
        ref.child(uid!).child("entries").child(timestamp).removeValue { (error, ref) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    func deleteExerciseEntryFromDatabase(index: Int, workouttimestamp: String) {
        let timestamp = exercises[index].timestamp
        let rootref = Database.database().reference()
        let ref = rootref.child("users")
        let uid = Auth.auth().currentUser?.uid
        ref.child(uid!).child("entries").child(workouttimestamp).child("exercises").child(timestamp).removeValue { (error, ref) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }


    static func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.string(from: date)
    }

    static func stringToDate(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.date(from: date)!
    }
}
