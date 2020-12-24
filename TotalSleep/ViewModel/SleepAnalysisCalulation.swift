//
//  SleepAnalysisCalulation.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 08.11.20.
//

import SwiftUI
import HealthKit

// USING

public class SleepAnalysisCalculation: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    //@Published var totalSlept = String()
    //@ObservedObject var fetcher = NetworkHelper()

    /* public func calculateSleep(result: [HKSample]) -> String {
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
                let isInBed = sleepValue == .inBed
                let isAwake = sleepValue == .awake
                    
                //print("HealthKit sleep Start: \(sample.startDate) End: \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
                
                // TODO: Zuordnen der Start- und Enddaten
                
                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                /*print("start: \(sample.startDate)")
                print("end: \(sample.endDate)")
                print("is asleep: \(isAsleep)")
                print("is in bed: \(isInBed)")
                print("is awake: \(isAwake)")
                print("interval: \(seconds) \n")*/

                
                //print("Interval in seconds: \(seconds)")
                if isAsleep == true {
                    totalSeconds = totalSeconds + Int(seconds)
                    //print("Total seconds asleep: \(totalSeconds)")
                }
                
                //print(sleepValue)
                
            })
        let totalMinutes = totalSeconds / 60
        totalHours = Int(totalMinutes) / 60
        totalMins = totalMinutes % 60

        //self.totalSlept = "Total slept: \(totalHours) hours \(totalMins) minutes"
        return "\(totalHours) hours \(totalMins) minutes"
    } */
    
    func calculateSleptSeconds(result: [HKSample]) -> (totalSeconds: Int, deviceHash: Int, deviceName: String, startTime: Date, endTime: Date) {
        var totalSeconds = Int()
        var deviceName = String()
        var deviceHash = Int()
        var startTime = Date()
        var endTime = Date()
        result
            .compactMap({ $0 as? HKCategorySample })
            .forEach({sample in
                guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                    return
                }
                
                let isAsleep = sleepValue == .asleep
                let isInBed = sleepValue == .inBed
                let isAwake = sleepValue == .awake
                    
                // print("HealthKit sleep Start: \(sample.startDate) End: \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
                
                // TODO: Zuordnen der Start- und Enddaten
                
                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                deviceName = sample.sourceRevision.source.name
                deviceHash = sample.sourceRevision.source.hash
                startTime = sample.startDate
                endTime = sample.endDate
                print("source revision name: \(String(describing: sample.sourceRevision.source.name))")
                print("source revision hash: \(String(describing: sample.sourceRevision.source.hash))")
                //print("source revision product type: \(String(describing: sample.sourceRevision.productType))")
                print("start: \(sample.startDate)")
                print("end: \(sample.endDate)")
                print("is asleep: \(isAsleep)")
                print("is in bed: \(isInBed)")
                print("is awake: \(isAwake)")
                print("interval: \(seconds) \n")
                
                if isAsleep == true {
                    totalSeconds = totalSeconds + Int(seconds)
                }
            })
        return (totalSeconds, deviceHash, deviceName, startTime, endTime)
    }
    
    /*func retrieveSleepAnalysis() {
            
            // startDate and endDate are NSDate objects
            
           // ...
            
            // first, we define the object type we want
            
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
                
                // You may want to use a predicate to filter the data... startDate and endDate are NSDate objects corresponding to the time range that you want to retrieve
                
                //let predicate = HKQuery.predicateForSamplesWithStartDate(startDate,endDate: endDate ,options: .None)
                
                // Get the recent data first
                
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
                
                // the block completion to execute
                
                let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 500, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                    
                    if error != nil {
                        
                        // Handle the error in your app gracefully
                        return
                        
                    }
                    
                    if let result = tmpResult {
                        
                        for item in result {
                            if let sample = item as? HKCategorySample {
                                
                                // let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                                
                                guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                                    return
                                }
                                
                                let isAsleep = sleepValue == .asleep
                                let isInBed = sleepValue == .inBed
                                let isAwake = sleepValue == .awake
                                    
                                // print("HealthKit sleep Start: \(sample.startDate) End: \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
                                
                                // TODO: Zuordnen der Start- und Enddaten
                                
                                let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                                print("start: \(sample.startDate)")
                                print("end: \(sample.endDate)")
                                print("is asleep: \(isAsleep)")
                                print("is in bed: \(isInBed)")
                                print("is awake: \(isAwake)")
                                print("interval: \(seconds) \n")
                                
                                // print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                                // print("Healthkit in Bed: \(HKCategoryValueSleepAnalysis.inBed): \(HKCategoryValueSleepAnalysis.inBed.rawValue)")
                            }
                        }
                    }
                }
            healthStore.execute(query)
            }
        } */
}
