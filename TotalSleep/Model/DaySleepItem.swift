//
//  SleepData.swift
//
//  Created by Sacha Schwab on 07.11.20.
//

import SwiftUI
import HealthKit

class DaySleepItem: ObservableObject, Identifiable {
    // unused (crap)
    let id = UUID()
    // @Published var day: Date = Date()
    var day: Date
    // @Published var samples = [HKSample]()
    // @Published var totalSleepMinutes: Int = 0
    var totalSleep: String
    
    /*func calculateTotalSleep(samples: [HKSample]) {
        objectWillChange.send()
        var totalMinutes = 0
        for item in samples {
            if let sample = item as? HKCategorySample {
                let value = HKCategoryValueSleepAnalysis(rawValue: sample.value)
                if value == .asleep {
                    let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                    totalMinutes += Int(seconds) / 60
                }
            }
        }
        self.totalSleepMinutes = totalMinutes
    }*/
    
    init(day: Date, totalSleep: String) {
        self.day = day
        self.totalSleep = totalSleep
        // self.samples = samples
    }
}
