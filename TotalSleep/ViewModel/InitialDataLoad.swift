//
//  InitialDataLoad.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 21.11.20.
//

import SwiftUI
import HealthKit

// USING

// Calculate the last 30 days sleep items
// TODO: Solve overlapping device data problem

class InitialDataLoad: ObservableObject {
    
    @Published var items = [DaySleepItem]()
    @ObservedObject var calculator = SleepAnalysisCalculation()
    @ObservedObject var mixed_calculator = MixedSourcesSleepCalculation()
    // let network = NetworkHelper()
    let queryHelper = QueryHelper()
    
    // X days = (standard) 30 days
    var daysBack = 20
    
    // Initialise
    init() {
        objectWillChange.send()

        // Make initial date time: today at 12pm
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "dd.MM.yyyy"
        let currentDateString: String = formatter.string(from: Date())
        // print("current date string: \(currentDateString)")
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        let initialDateTime: Date = formatter.date(from: currentDateString + " 14:00") ?? Date()
        // print("initial date: \(initialDateTime)")
        
        // Loop through past X days
        for day in 1..<self.daysBack {
            guard let startDateTime = Calendar.current.date(byAdding: .day, value: -day, to: initialDateTime) else { return }
            guard let endDateTime = Calendar.current.date(byAdding: .day, value: -day+1, to: initialDateTime) else {
                return }
            // Read Sleep Data from day
            queryHelper.querySleep(startDateTime: startDateTime, endDateTime: endDateTime, completion: { (result) in
                // Calculate Total time slept
                let sleptSecondsCalculationResult = self.calculator.calculateSleptSeconds(result: result)
                
                
                let mixedSleepResult = self.mixed_calculator.calculateSleptSeconds(result: result)
                print("-----------------------------------------------------------------------------")
                print("Mixed sleep calculateion result in seconds = \(mixedSleepResult)")
                print("For date = \(String(describing: endDateTime))")
                print("-----------------------------------------------------------------------------")
                
                // Append items
                //print("date:  \(endDateTime) total seconds slept: \(totalSleptSeconds)")
                let totalMinutes = mixedSleepResult / 60
                
                let totalHours = Int(totalMinutes) / 60
                let totalMins = totalMinutes % 60
                var totalSleptText: String = ""
                if totalMins == 1 {
                    totalSleptText = "\(totalHours) hours \(totalMins) minute"
                } else {
                    totalSleptText = "\(totalHours) hours \(totalMins) minutes" }
                formatter.dateFormat = "EEEE, dd MMM yyyy"
                let dateString = formatter.string(from: endDateTime)
                self.items.append(DaySleepItem(day: endDateTime, dayString: dateString, totalSleep: totalSleptText, totalSecondsSlept: sleptSecondsCalculationResult.totalSeconds))
                // TODO: When Core Data, sort in fetch for list:
                self.items = self.items.sorted {
                    $0.day > $1.day
                }
            })
        }
    }
}

    

        

        // With ther result, calculate total sleep in seconds

        // Convert in hours + minutes

        // Append to model
