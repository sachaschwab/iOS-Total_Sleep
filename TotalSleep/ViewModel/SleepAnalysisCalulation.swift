//
//  SleepAnalysisCalulation.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 08.11.20.
//

import SwiftUI
import HealthKit

public class SleepAnalysisCalculation: ObservableObject {
    
    //@Published var totalSlept = String()
    //@ObservedObject var fetcher = NetworkHelper()

    public func calculateSleep(result: [HKSample]) -> String {
        var totalSeconds = Int()
        var totalHours = Int()
        var totalMins = Int()
        // var earliestTime = Date()
        // var latestTime = Date()
        // print("passed result: \(fetcher.analysisResult)")
        result
            .compactMap({ $0 as? HKCategorySample })
            .forEach({sample in
                guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                    return
                }
                let isAsleep = sleepValue == .asleep
                
                //print("HealthKit sleep Start: \(sample.startDate) End: \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
                
                // TODO: Zuordnen der Start- und Enddaten
                
                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                
                //print("Interval in seconds: \(seconds)")
                if isAsleep == true {
                    totalSeconds = totalSeconds + Int(seconds)
                    //print("Total seconds asleep: \(totalSeconds)")
                }
                
                print(sleepValue)
                
            })
        let totalMinutes = totalSeconds / 60
        totalHours = Int(totalMinutes) / 60
        totalMins = totalMinutes % 60

        //self.totalSlept = "Total slept: \(totalHours) hours \(totalMins) minutes"
        return "\n \(totalHours) hours \(totalMins) minutes"
    }
}
