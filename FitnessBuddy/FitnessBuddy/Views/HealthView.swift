//
//  HealthView.swift
//  FitnessBuddy
//
//  Created by Tatiana Bondarenko on 8/5/22.
//

import SwiftUI
import HealthKit

struct HealthView: View {
    @State var healthManager = HealthManager()
    @State var heartRate: Double = 0.0
    
    var body: some View {
        
        
        HStack(spacing: 30) {
                ZStack {
                    Color.gray.edgesIgnoringSafeArea(.all)
                    Text("HeartRate")
                    .bold()
                }.frame(width: 140, height: 80)

                ZStack {
                    Color.gray.edgesIgnoringSafeArea(.all)

                    Text("\(heartRate)")
                    .bold()
                }.frame(width: 140, height: 80)
        }.onAppear {
            healthManager.autorizeHealthKit()
            getLatestHeartRate()
            
        }
    }
    
    func getLatestHeartRate() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { sample, result, error in
            guard error == nil else {
                return
            }
            
            let data = result![0] as! HKQuantitySample
            let unit = HKUnit(from: "count/min")
            let latestHR = data.quantity.doubleValue(for: unit)
            
            DispatchQueue.main.async {
                heartRate = latestHR
            }
        }
        healthManager.healthStore.execute(query)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}
