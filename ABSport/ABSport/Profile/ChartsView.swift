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
            }
            
            .foregroundColor(.lightGray)
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
                .foregroundStyle(getColor(for: dataSeries.type))
            }
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks { _ in
                    AxisValueLabel()
                }
            }
            .chartYScale(domain: 0...100)
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
    
    private func getColor(for type: String) -> Color {
        switch type {
            case "Мышцы":
                return .blue
            case "Жир":
                return Color(red: 0.3, green: 0.7, blue: 0.2) // Рыжий цвет
            case "Вода":
                return .red // Голубой цвет
            default:
                return .black
            }
        }
}
#Preview {
    ChartsViewIMT()
}
