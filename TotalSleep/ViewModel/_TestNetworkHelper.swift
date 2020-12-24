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
            //print("initialized TestNetworkHelper")
            self.analysisResult = result
            //print("finished NetworkHelper")
            
            let currentDate = Calendar.current.date(byAdding: .day, value: -0, to: Date())
            
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "EEEE, dd.MM.yyyy"
            let currentDateString: String = formatter.string(from: currentDate ?? Date())
            
            // Append items
            // self.totalSlept = self.calculator.calculateSleep(result: result)
            self.items.append(DaySleepItem(day: Date(), dayString: "Monday", totalSleep: self.totalSlept, totalSecondsSlept: 0))
        })
    }
}
