//
//  ChartsView.swift
//  ABSport
//
//  Created by mac on 14.04.2024.
//

import SwiftUI
import Charts
import CoreData

struct ChartsViewWeight: View {
    
    let backData = PetData.backData
    let dataWeight = PetData.dataWeight
    
    var dataSet: [(type: String, data: [PetData])] {
        [(type: "back", data: backData), (type: "main", data: dataWeight)]
    }
    
    var body: some View {
        ZStack {
            Chart {
                ForEach(backData) { data in
                    BarMark(x: .value("Type", data.type),
                            y: .value("Mass", data.count))
                }
                .cornerRadius(6.0)
            }
            
            .foregroundColor(Color("BarMarkBackColor"))
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { _ in
                    AxisValueLabel()}
            }
            Chart {
                ForEach(dataWeight) { data in
                    BarMark(x: .value("Type", data.type),
                            y: .value("Mass", data.count))
                }
                .cornerRadius(6.0)
            }
            .foregroundStyle(Color("BarMarkWeightColor"))
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
