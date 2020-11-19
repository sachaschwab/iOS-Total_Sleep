//
//  DaySleepCell.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 19.11.20.
//

import SwiftUI

struct DaySleepCell: View {
    
    let cellTitleText: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(cellTitleText)
                    .font(.title)
                Text("some subtitle")
                    .font(.subheadline)
            }
        }
}

struct DaySleepCell_Previews: PreviewProvider {
    static var previews: some View {
            let mockData = "Ciao World"
            DaySleepCell(cellTitleText: mockData)
        }
}
