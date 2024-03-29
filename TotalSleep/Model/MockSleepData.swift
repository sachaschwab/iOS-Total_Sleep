//
//  MockData.swift
//
//  Created by Sacha Schwab on 07.11.20.
//

import SwiftUI

class MockSleepData: ObservableObject {
    
    @Published var items = [DaySleepItem]()
    @ObservedObject var calculator = SleepAnalysisCalculation()
    //let network = NetworkHelper()
    //let queryHelper = QueryHelper()
    
    init?() {
        objectWillChange.send()
        
        guard let currentDate = Calendar.current.date(byAdding: .day, value: -0, to: Date()) else { return nil }
        guard let pastDayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return nil }
        
        // Append items
        items.append(DaySleepItem(day: currentDate, dayString: "Monday", totalSleep: "6 hours 5 minutes", totalSecondsSlept: 0))
        items.append(DaySleepItem(day: pastDayDate, dayString: "Tuesday", totalSleep: "8 hours 30 minutes", totalSecondsSlept: 0))
    }
}
