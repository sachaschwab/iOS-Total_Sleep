//
//  ContentView.swift
//  TotalSleep WatchKit Extension
//
//  Created by Sacha Schwab on 04.11.20.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    //@ObservedObject var network = NetworkHelper()
    
    public var healthStoreAuth = HKHealthStore()
    
    var body: some View {
        /*Text(network.totalSlept)
            .padding()
            .onAppear(perform: {
                start()
            })*/
        Text("Text will go here")
        
    }
    
    func start() {
        // print("Started")
        authorizeSleepAnalysis()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
