//
//  DaySleepList.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 19.11.20.
//

import SwiftUI

struct DaySleepList: View {
    
    @ObservedObject var sleepItemData = TestNetworkHelper()!
    
    var body: some View {
        List {
            ForEach(sleepItemData.items) { item in
                DaySleepCell(cellTitleText: item.totalSleep)
            }
        }
    }
}

struct DaySleepList_Previews: PreviewProvider {
    static var previews: some View {
        DaySleepList()
    }
}
