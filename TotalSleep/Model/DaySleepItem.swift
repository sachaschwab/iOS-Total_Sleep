//
//  SleepData.swift
//
//  Created by Sacha Schwab on 07.11.20.
//

import SwiftUI
import HealthKit

// USING

class DaySleepItem: ObservableObject, Identifiable {
    let id = UUID()
    var day: Date
    var dayString: String
    var totalSleep: String
    var totalSecondsSlept: Int = 0
    
    init(day: Date, dayString: String, totalSleep: String, totalSecondsSlept: Int) {
        self.day = day
        self.dayString = dayString
        self.totalSleep = totalSleep
        self.totalSecondsSlept = totalSecondsSlept
    }
}
