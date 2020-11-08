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
        print("init NetworkHelper")
        readSleepData(completion: { (result) in
            print("initialized NetworkHelper")
            self.analysisResult = result
            print("result from return: \(result.count)")
            print("finished NetworkHelper")
            self.totalSlept = self.calculator.calculateSleep(result: result)
        })
        }
    
    public func readSleepData(completion: @escaping ([HKSample]) -> Void) {
        // first, we define the object type we want
        
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        
        // Get the dates
        // DEV Data
        /*let formatter = DateFormatter()
         formatter.dateFormat = "yyyy/MM/dd HH:mm"
         let startDate = formatter.date(from: "2020/10/27 18:00")
         let endDate = formatter.date(from: "2020/10/29 08:00")
         readSleepData(from: startDate, to: endDate)*/
        
        // Get current time stamp and deduct one day to create the start date
        let currentDate = Date()
        // Format to ... seconds date format
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd HH:mm"
        let formattedEndDate = format.string(from: currentDate)
        // Debug
        print("Start Date: \(formattedEndDate)")
        // Day deduction produces an optional to unwrap
        let pastDayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())

        if let unwrappedStartDate = pastDayDate {
            //readSleepData(from: unwrappedStartDate, to: Date())
            //print(type(of: unwrappedStartDate))
            //endDate = unwrappedStartDate
            
            // we create a predicate to filter our data, and a sort description
            // TODO: Wrap into seperate function
            let predicate = HKQuery.predicateForSamples(withStart: unwrappedStartDate, end: Date(), options: .strictStartDate)
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            // Create query
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 50, sortDescriptors: [sortDescriptor]) {(query, result, error) in
                if error != nil {
                    return
                }
                
                if let result = result {
                    //print("passing result: \(result)")
                    self.analysisResult = result
                    print("result count: \(self.analysisResult.count)")
                } else {
                    completion(result ?? [])
                    return
                }
                
                DispatchQueue.main.async {
                    completion(result ?? [])
                }
            }
            // finally, we execute our query
            
            let healthStore = HKHealthStore()
            healthStore.execute(query)
            print("passing result count: \(self.analysisResult.count)")
        }
    }
}
