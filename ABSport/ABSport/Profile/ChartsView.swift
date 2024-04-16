//
//  ChartsView.swift
//  ABSport
//
//  Created by mac on 14.04.2024.
//

import SwiftUI
import Charts


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

struct ChartsViewIMT: View {
    
    let dataMuscules = PetData.dataMuscles
    let dataFat = PetData.dataFat
    let dataWater = PetData.dataWater
    
    var dataSet: [(type: String, data: [PetData])] {
        [(type: "Мышцы", data: dataMuscules),
         (type: "Жир", data: dataFat),
         (type: "Вода", data: dataWater)]
    }

    var body: some View {
        VStack {
            Chart(dataSet, id: \.type) {dataSeries in
                ForEach(dataSeries.data) { data in
                    BarMark(x: .value("Type", data.type),
                            y: .value("Index", data.count))
                }
                .cornerRadius(6.0)
                .foregroundStyle(getColor(for: dataSeries.type))
            }
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { _ in
                    AxisValueLabel()
                }
            }
            .chartYScale(domain: 0...100)
            
            HStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 6.0)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color("BarMarkWeightColor"))
                Text("Мышцы")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                RoundedRectangle(cornerRadius: 6.0)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color("BarMarkFatColor"))
                Text("Жир")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                RoundedRectangle(cornerRadius: 6.0)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color("BarMarkWaterColor"))
                Text("Вода")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
    
    private func getColor(for type: String) -> Color {
        switch type {
            case "Мышцы":
                return Color("BarMarkWeightColor")
            case "Жир":
                return Color("BarMarkFatColor")
            case "Вода":
                return Color("BarMarkWaterColor")
            default:
                return .black
            }
        }
}
#Preview {
    ChartsViewIMT()
}
