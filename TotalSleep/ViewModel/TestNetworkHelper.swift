//
//  TestNetworkHelper.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 19.11.20.
//

import SwiftUI
import HealthKit

class TestNetworkHelper: ObservableObject {
    
    @Published var items = [DaySleepItem]()
    
    @ObservedObject var calculator = SleepAnalysisCalculation()
    
    @Published var totalSlept = "Sali" // Dummy
    
    let network = NetworkHelper()
    @Published var analysisResult = [HKSample]()
    
    init?() {
        objectWillChange.send()
        
        network.readSleepData(completion: { (result) in
            print("initialized NetworkHelper")
            self.analysisResult = result
            print("result from return: \(result.count)")
            print("finished NetworkHelper")
            
            let currentDate = Calendar.current.date(byAdding: .day, value: -0, to: Date())
            
            // Append items
            self.totalSlept = self.calculator.calculateSleep(result: result)
            self.items.append(DaySleepItem(day: currentDate ?? Date(), totalSleep: self.totalSlept))
        })
        
        
    }
}
