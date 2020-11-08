//
//  AuthHelper.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 08.11.20.
//

import SwiftUI
import HealthKit

extension ContentView {
    
    func authorizeSleepAnalysis() {
        let typesToRead: Set = [
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!]
        
        // Don't need this as long as no write needed
        /*let typesToShare: Set = [
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!]*/
        
        healthStoreAuth.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) -> Void in
            if success == false {
                NSLog(" Display not allowed")
            } else {
                NSLog("Authorisation to SleepAnalysis granted")
            }
        }
    }
}
