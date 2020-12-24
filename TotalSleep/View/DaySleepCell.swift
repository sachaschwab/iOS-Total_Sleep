//
//  DaySleepCell.swift
//  TotalSleep
//
//  Created by Sacha Schwab on 19.11.20.
//

import SwiftUI

struct DaySleepCell: View {
    
    let cellTitleText: String
    let cellSubTitleText: String
        
    var body: some View {
        VStack(alignment: .leading){
            Text(cellTitleText)
                .font(.title)
                .foregroundColor(Color.white)
            Text(cellSubTitleText)
                .font(.subheadline)
                .foregroundColor(Color.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color.black)
        )
    }
}

struct DaySleepCell_Previews: PreviewProvider {
    static var previews: some View {
            let mockTitle = "Ciao World"
            let mockSubTitle = "22.11.2020"
        DaySleepCell(cellTitleText: mockTitle, cellSubTitleText: mockSubTitle)
            .previewLayout(PreviewLayout.sizeThatFits)
        }
}
