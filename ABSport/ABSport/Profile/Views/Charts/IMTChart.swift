//
//  IMTChart.swift
//  ABSport
//
//  Created by mac on 14.05.2024.
//

import SwiftUI
import Charts

struct ChartsViewIMT: View {
    
    @State private var showingSheetInsert: Bool = false
    @State private var showingSheetChange: Bool = false
    @State private var weight: String = ""
    @State private var showAlertInsert: Bool = false
    @State private var showAlertChange: Bool = false
    
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
            .aspectRatio(1, contentMode: .fit)
            
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
            HStack {
                Text("Дата:")
                Text("04.03.2023")
                    .foregroundColor(.secondary)
                Text("Рост:")
                Text("182 см")
                    .foregroundColor(.secondary)
                Text("Вес:")
                Text("76 кг")
                    .foregroundColor(.secondary)
            }
            .font(.system(size: 14))
            
//            Button(action: { showingSheetChange.toggle()}){
//                Text("Изменить данные")
//                    .foregroundStyle(Color("BlueButtonColor"))
//                    .underline()
//            }
            .padding()
            HStack {
                Text("Чтобы узнать данные пармаетры, вы можете воспользоваться бесплатной услугой")
                    .foregroundColor(.secondary)
                .font(.system(size: 14))
            }
            Button(action: {}) {
                Text("Биоимпедансный анализ")
                    .foregroundStyle(Color("GreenTextColor"))
                    .font(.system(size: 14))
            }
            Spacer()
//            Button(action: { }) {
//                Text("Внести данные")
//                    .font(.system(size: 15))
//                    .frame(height: 56)
//                    .frame(maxWidth: .infinity)
//                    .foregroundColor(.white)
//                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.blue))
//            }
//            .padding()
        }
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

