//
//  HealthManager.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/7/22.
//

import HealthKit

class HealthManager {
    var healthStore = HKHealthStore()
    
    static var heartRate: Double?

    func autorizeHealthKit() {
        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { chk, error in
            if(chk) {
                print("Permission granted")
            }
        }
    }
}
