//
//  MixedSourcesSleepCalculation.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 29.11.20.
//

import SwiftUI
import HealthKit

public class MixedSourcesSleepCalculation: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    
    
    func calculateSleptSeconds(result: [HKSample]) -> Int {

        var totalSeconds = Int()
        // let deviceHash_1 = Int()
        // var deviceHash_2 = Int()
        var startTime_1 = Date()
        var endTime_1 = Date()
        var startTime_2 = Date()
        var endTime_2 = Date()
        
        result
            .compactMap({ $0 as? HKCategorySample })
            .forEach({sample in
                guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                    return
                }

                let isAsleep = sleepValue == .asleep
                let isInBed = sleepValue == .inBed
                let isAwake = sleepValue == .awake

                let seconds = sample.endDate.timeIntervalSince(sample.startDate)

                if isAsleep == true {
                    
                    startTime_2 = sample.startDate
                    endTime_2 = sample.endDate
                    
                    if startTime_1 != endTime_1 {

                        // Reject 2 case (both exactly the same)
                        // Interval 1  |*****|
                        // Interval 2  |*****|
                        
                        if startTime_1 != startTime_2 {
                            
                            // Vanilla case:
                            // Interval 1  |*****|
                            // Interval 2           |***|
                            
                            if endTime_1 < startTime_2 {
                                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                                totalSeconds = totalSeconds + Int(seconds)
                                startTime_1 = startTime_2
                                endTime_1 = endTime_2
                            }
                            
                            if endTime_1 > startTime_2 && endTime_1 < endTime_2 && startTime_1 < startTime_2 {
                                // Take start date from Interval 1 + end date from Interval 2 case:
                                // Interval 1  |*****|
                                // Interval 2       |***|
                                // Here we need to deduct the interval 1 since it has already been added to total
                                let seconds = endTime_2.timeIntervalSince(startTime_1)
                                let secondsToDeduct = endTime_1.timeIntervalSince(startTime_1)
                                totalSeconds = totalSeconds + Int(seconds) - Int(secondsToDeduct)
                                // startTime_1 remains the same
                                endTime_1 = endTime_2
                            }
                            
                            if endTime_1 > startTime_2 && endTime_1 < endTime_2 && startTime_1 > startTime_2 {
                                // Take start date from Interval 2 + end date from Interval 2 case:
                                // Interval 1         |***|
                                // Interval 2       |*******|
                                // Also here we need to deduct the interval 1 since it has already been added to total
                                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                                let secondsToDeduct = endTime_1.timeIntervalSince(startTime_1)
                                totalSeconds = totalSeconds + Int(seconds) - Int(secondsToDeduct)
                                startTime_1 = startTime_2
                                endTime_1 = endTime_2
                            }
                            
                            if endTime_1 > startTime_2 && endTime_1 > endTime_2 && startTime_1 > startTime_2 {
                                // Skip case:
                                // Interval 1              |*****|
                                // Interval 2       |***|
                                // remains: startTime_1 = startTime_1
                                // remains: endTime_1 = endTime_1
                            }
                            
                            if endTime_1 > startTime_2 && endTime_1 > endTime_2 && startTime_1 < startTime_2 {
                                // Skip case:
                                // Interval 1          |*****|
                                // Interval 2       |***|
                                startTime_1 = startTime_2
                            }
                        }
                        
                        let totalMinutes = totalSeconds / 60
                        let totalHours = Int(totalMinutes) / 60
                        let totalMins = totalMinutes % 60
                        print("Total slept seconds so far: \(totalHours) hours \(totalMins) minutes")
                        print("\(totalSeconds) seconds")
                    } else {
                        startTime_1 = startTime_2
                        endTime_1 = endTime_2
                        let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                        totalSeconds = totalSeconds + Int(seconds)
                        print("\(totalSeconds) initial seconds")
                    }
                    
                    // Else, continue
                }
            })
        return totalSeconds
    }
}
