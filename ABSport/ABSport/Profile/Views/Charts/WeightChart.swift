//
//  WeightChart.swift
//  ABSport
//
//  Created by mac on 14.05.2024.
//

import SwiftUI
import Charts

struct Weight: View {
    
    @Environment (\.managedObjectContext) var context
    @FetchRequest(fetchRequest: WeightChart.fetch()) var weightChart: FetchedResults<WeightChart>
    
    @State private var showingSheetInsert: Bool = false
    @State private var showingSheetChange: Bool = false
    @State private var weight: String = ""
    @State private var showAlertInsert: Bool = false
    @State private var showAlertChange: Bool = false
    
    var body: some View {
        VStack {
            Chart {
                ForEach(weightChart) {data in
                    LineMark(x: .value("Date", data.date),
                             y: .value("Weight", data.weight))
                    .symbol(.circle)
                }
                .interpolationMethod(.catmullRom)
            }
            .chartYScale(domain: 0...150)
            .padding()
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
            
            Button(action: { showingSheetChange.toggle()}) {
                Text("Изменить данные")
                    .foregroundStyle(Color("BlueButtonColor"))
                    .underline()
            }
            .padding()
            .sheet(isPresented: $showingSheetChange) {
                VStack {
                    TextField("Введите вес", text: $weight)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Готово") {
                        if let weightFloat = Float(weight), weightFloat > 0 {
                            WeightChart.editLast(with: weightFloat, context: context)
                            showAlertChange = false
                            showingSheetChange = false
                        } else {
                            showAlertChange = true
                        }
                    }
                    .padding()
                }
                .presentationDetents([.medium])
                .alert(isPresented: $showAlertChange) {
                    Alert(
                        title: Text("Ошибка"),
                        message: Text("Пожалуйста, введите корректный вес (положительное число)"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            Spacer()
            
            Button(action: { showingSheetInsert.toggle() }) {
                Text("Внести данные")
                    .font(.system(size: 15))
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.blue))
            }
            .padding()
            .sheet(isPresented: $showingSheetInsert) {
                VStack {
                    TextField("Введите вес", text: $weight)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Готово") {
                        if let weightFloat = Float(weight), weightFloat > 0 {
                            let mark = WeightChart(weight: weightFloat, date: Date(), context: context)
                            PersistenceController.shared.save()
                            showAlertInsert = false
                            showingSheetInsert = false
                        } else {
                            showAlertInsert = true
                        }
                    }
                    .padding()
                }
                .presentationDetents([.medium])
                .alert(isPresented: $showAlertInsert) {
                    Alert(
                        title: Text("Ошибка"),
                        message: Text("Пожалуйста, введите корректный вес (положительное число)"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}
