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
    @State var heartRate: Double = 60.0
    
    @State var sliderValue: Double = 25
    @State var color: Color = .red
    @State private var progress = 0.5
    
    var body: some View {
        NavigationView {
        VStack(spacing: 30) {
            Text("Heart rate: \(String(format: "%.0f", heartRate))")
                .bold()
                .foregroundColor(color)
            ZStack {
                Rectangle().fill(LinearGradient(colors: [.blue, .green, .yellow, .orange, .red], startPoint: .leading, endPoint: .trailing))
                    .frame(width: UIScreen.main.bounds.width - 10, height: 10)
                    .cornerRadius(15)
                    .padding(.horizontal)
            }
            
            Text("Your age: \(String(format: "%.0f", sliderValue))")
            Slider(
                value: $sliderValue,
                in: 1...150,
                step: 1.0) { (_) in
                    color = .green
                }
                .padding()
            
            Image("hrzones")
                .resizable()
                .aspectRatio(contentMode: .fit)
                    
                .navigationTitle("Check your latest heart rate")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
//            healthManager.autorizeHealthKit()
//            getLatestHeartRate()
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
        NavigationView {
            HealthView()
        }
    }
}
