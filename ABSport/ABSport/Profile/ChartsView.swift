//
//  ChartsView.swift
//  ABSport
//
//  Created by mac on 14.04.2024.
//

import SwiftUI
import Charts


struct ChartsView: View {
    
    let backData = PetData.backData
    let dataPet = PetData.data
    
    var dataSet: [(type: String, data: [PetData])] {
        [(type: "back", data: backData), (type: "main", data: dataPet)]
    }
    
    var body: some View {
        ZStack {
            Chart {
                ForEach(backData) { data in
                    BarMark(x: .value("Type", data.type),
                            y: .value("Mass", data.count))
                    .cornerRadius(15.0, style: .continuous)}
            }
            
            .foregroundColor(.lightGray)
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { _ in
                    AxisValueLabel()}
            }
            Chart {
                ForEach(dataPet) { data in
                    BarMark(x: .value("Type", data.type),
                            y: .value("Mass", data.count))
                    .cornerRadius(15.0, style: .continuous)}
            }
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { _ in
                    AxisValueLabel()}
            }
            .chartYScale(domain: 0...80)
            
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

#Preview {
    ChartsView()
}
