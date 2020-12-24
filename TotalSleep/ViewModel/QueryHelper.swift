//
//  QueryHelper.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 21.11.20.
//

import SwiftUI
import HealthKit

// USING

class QueryHelper {
    
    @ObservedObject var calculator = SleepAnalysisCalculation()
    
    func querySleep(startDateTime: Date, endDateTime: Date, completion: @escaping ([HKSample]) -> Void) {
        // first, we define the object type we want
        
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        let predicate = HKQuery.predicateForSamples(withStart: startDateTime, end: endDateTime, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        // print("creating query")
        // Create query
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 50, sortDescriptors: [sortDescriptor]) {(query, result, error) in
            if error != nil {
                return }
            if let result = result {
                //print("passing result: \(result)")
            } else {
                completion(result ?? [])
                return }
            
            DispatchQueue.main.async {
                completion(result ?? [])
            }
        }
        // finally, we execute our query
        // print("execute query")
        let healthStore = HKHealthStore()
        healthStore.execute(query)
    }
}
