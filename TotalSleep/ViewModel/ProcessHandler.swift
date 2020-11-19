//
//  ProcessHandler.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 11.11.20.
//

import SwiftUI
import HealthKit


public class ProcessHandler {
    
    let healthStore = HKHealthStore()

    func saveSleepAnalysis() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let startTime = formatter.date(from: "2020-11-11 20:00") else { return }
        guard let alarmTime = formatter.date(from: "2020-11-12 08:00") else { return }
         
        // alarmTime and endTime are NSDate objects
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            
            // we create our new object we want to push in Health app
            let object = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.inBed.rawValue, start: startTime, end: alarmTime)
            
            // at the end, we save it
            self.healthStore.save(object, withCompletion: { (success, error) -> Void in
                
                if error != nil {
                    // something happened
                    return
                }
                
                if success {
                    print("My new data was saved in HealthKit")
                    
                } else {
                    // something happened again
                }
                
            })
            
            /*
            let object2 = HKCategorySample(type:sleepType, value: HKCategoryValueSleepAnalysis.Asleep.rawValue, startDate: self.alarmTime, endDate: self.endTime)
            
            healthStore.saveObject(object2, withCompletion: { (success, error) -> Void in
                if error != nil {
                    // something happened
                    return
                }
                
                if success {
                    print("My new data (2) was saved in HealthKit")
                } else {
                    // something happened again
                }
                
            })
            
        } */
        
        }
    }
}
