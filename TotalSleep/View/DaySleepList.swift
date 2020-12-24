//
//  DaySleepList.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 19.11.20.
//

import SwiftUI

struct DaySleepList: View {

    @ObservedObject var sleepItemData = InitialDataLoad()

    var body: some View {
        let itemsToDisplay = todayItems()
        List {
            ForEach(itemsToDisplay) { item in
                DaySleepCell(cellTitleText: item.totalSleep, cellSubTitleText: item.dayString)
            }
            .listRowBackground(RadialGradient(gradient: Gradient(colors: [.black, .purple]), center: .center, startRadius: 1, endRadius: 300))
        }
    }
    
    // Show only today's item
    func todayItems() -> [DaySleepItem] {
            let filterData = sleepItemData.items
            let filtered = filterData.filter {
                Calendar.current.isDateInToday($0.day)
            }
            
            for item in filtered {
                print(String(describing: item.day))
            }
            
            return filtered
        }
}

struct DaySleepList_Previews: PreviewProvider {
    @ObservedObject static var sleepItemData = MockSleepData()!
    
    static var previews: some View {
        let item = sleepItemData.items.first
        List {
            //ForEach(sleepItemData.items) { item in
            DaySleepCell(cellTitleText: item!.totalSleep, cellSubTitleText: item!.dayString)
            //}
            //.listRowBackground(RadialGradient(gradient: Gradient(colors: [.black, .purple]), center: .center, startRadius: 1, endRadius: 300))
        }
    }
}
