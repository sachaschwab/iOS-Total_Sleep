//
//  NetworkHelper.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 08.11.20.
//

import SwiftUI
import HealthKit

public class NetworkHelper: ObservableObject {
    let x = 0
    @ObservedObject var calculator = SleepAnalysisCalculation()
    
    @Published var analysisResult = [HKSample]()
    @Published var totalSlept = "Sali"
    
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    init(){
        //print("init NetworkHelper")
        readSleepData(completion: { (result) in
            //print("initialized NetworkHelper")
            self.analysisResult = result
            //print("result from return: \(result.count)")
            //print("finished NetworkHelper")
            // self.totalSlept = self.calculator.calculateSleep(result: result)
            //self.calculator.retrieveSleepAnalysis()
        })
    }
    func updateView(){
        self.objectWillChange.send()
        readSleepData(completion: { (result) in
            self.analysisResult = result
            // self.totalSlept = self.calculator.calculateSleep(result: result)
        })
    }
    
    public func readSleepData(completion: @escaping ([HKSample]) -> Void) {
        // first, we define the object type we want
        
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        
        let currentDate = Calendar.current.date(byAdding: .day, value: -0, to: Date())
        let pastDayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())

        if let unwrappedStartDate = pastDayDate {

            let predicate = HKQuery.predicateForSamples(withStart: unwrappedStartDate, end: currentDate, options: .strictStartDate)
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
            //print("creating query")
            // Create query
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 50, sortDescriptors: [sortDescriptor]) {(query, result, error) in
                if error != nil {
                    return
                }
                
                if let result = result {
                    //print("passing result: \(result)")
                    self.analysisResult = result
                    //print("result : \(self.analysisResult)")
                    
                } else {
                    completion(result ?? [])
                    return
                }
                
                DispatchQueue.main.async {
                    completion(result ?? [])
                }
            }
            // finally, we execute our query
            //print("execute query")
            let healthStore = HKHealthStore()
            healthStore.execute(query)
            //print("passing result count: \(self.analysisResult.count)")
        }
    }
}
