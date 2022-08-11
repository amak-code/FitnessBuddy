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
    @State var heartRate: Double = 113.0
    
    @State var sliderValue: Double = 25
    @State var color: Color = .blue
    @State var text: String = "zone1"
    
    
    @State private var showingPopover = false
    
    @State private var zone1: Double = 0
    @State private var zone5: Double = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                TitleText(text: "Health")
                HStack {
                    Text("Your latest heart rate: \(String(format: "%.0f", heartRate)) bpm")
                        .bold()
                        .foregroundColor(Color("AccentDark"))
                    Button {
                        showingPopover = true
                    } label: {
                        Image(systemName: "info.circle.fill")
                    }
                    .popover(isPresented: $showingPopover) {
                        Text("Disclaimer: Heart rate data can be used to gauge the intensity of your workout, and training within certain heart rate zones can provide specific fitness benefits. This application is not meant to replace professional medical advice. Please, check with your doctor prior to starting any health or fitness routine!")
                            .font(.headline)
                            .padding()
                    }
                }
                
                VStack(spacing: 4) {
                    Text("Your age: \(String(format: "%.0f", sliderValue))")
                    Slider(
                        value: $sliderValue,
                        in: 1...150,
                        step: 1.0) { (_) in
                            zone1 = calculateHeartRateZone(age: Int(sliderValue))[0]
                            zone5 = calculateHeartRateZone(age: Int(sliderValue)).last ?? 220
                            updateView(latestHR: heartRate, age: Int(sliderValue), color: &color, text: &text)
                        }
                        .padding(.horizontal)
                }
                
                HStack {
                    Text("Your heart rate is in: ")
                        .foregroundColor(color)
                    Text(text)
                        .frame(width: 150, height: 30)
                        .background(color)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                
                ZStack {
                    Rectangle().fill(LinearGradient(colors: [.blue, .green, .yellow, .orange, .red], startPoint: .leading, endPoint: .trailing))
                        .frame(width: UIScreen.main.bounds.width - 10, height: 10)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    Slider(value: $heartRate, in: zone1-50...zone5)
                        .padding(.horizontal)
                        .tint(.clear)
                        .disabled(true)
                }
                
                Image("hrzones")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                    .navigationTitle("")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
            healthManager.autorizeHealthKit()
            // comment out the line below when testing on a real device
            // getLatestHeartRate()
            zone1 = calculateHeartRateZone(age: Int(sliderValue))[0]
            zone5 = calculateHeartRateZone(age: Int(sliderValue)).last ?? 220
            updateView(latestHR: heartRate, age: Int(sliderValue), color: &color, text: &text)
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
    
    func calculateHeartRateZone(age: Int) -> [Double] {
        let maxHeartRate: Double = 220 - Double(age)
        
        let zone1 = maxHeartRate / 100 * 60
        let zone2 = maxHeartRate / 100 * 70
        let zone3 = maxHeartRate / 100 * 80
        let zone4 = maxHeartRate / 100 * 90
        let zone5 = maxHeartRate
        
        return [zone1, zone2, zone3, zone4, zone5]
    }
    
    func updateView(latestHR: Double, age: Int, color: inout Color, text: inout String) {
        
        if latestHR <= calculateHeartRateZone(age: age)[0] {
            color = .blue
            text = "zone1"
        } else if latestHR <= calculateHeartRateZone(age: age)[1] {
            color = .green
            text = "zone2"
        }
        else if latestHR <= calculateHeartRateZone(age: age)[2] {
            color = .yellow
            text = "zone3"
        }
        else if latestHR <= calculateHeartRateZone(age: age)[3] {
            color = .orange
            text = "zone4"
        }
        else if latestHR <= calculateHeartRateZone(age: age).last ?? 220 {
            color = .red
            text = "zone5"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HealthView()
        }
    }
}
