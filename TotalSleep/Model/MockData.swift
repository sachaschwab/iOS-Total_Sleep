//
//  MockData.swift
//
//  Created by Sacha Schwab on 07.11.20.
//

import SwiftUI

class MockSleepData: ObservableObject {
    
    @Published var items = [DaySleepItem]()
    
    init?() {
        objectWillChange.send()
        
        guard let currentDate = Calendar.current.date(byAdding: .day, value: -0, to: Date()) else { return nil }
        guard let pastDayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return nil }
        
        // Append items
        items.append(DaySleepItem(day: currentDate, totalSleep: "6 hours 5 minutes"))
        items.append(DaySleepItem(day: pastDayDate, totalSleep: "8 hours 30 minutes"))
    }
}
