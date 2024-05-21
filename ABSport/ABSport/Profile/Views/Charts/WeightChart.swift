//
//  WeightChart.swift
//  ABSport
//
//  Created by mac on 14.05.2024.
//

import SwiftUI
import Charts

enum SelectButton {
    case week
    case month
    case sixMonth
    case year
}

struct Weight: View {
    var dataManager: ChartDataManager = ChartDataManager()
    @Environment (\.managedObjectContext) var context
    @FetchRequest(fetchRequest: WeightChart.fetch()) var weightChart: FetchedResults<WeightChart>
    @State private var filterData: [WeightChart] = []
    
    @State private var selectedButton: SelectButton = .week
    
    @State private var showingSheetInsert: Bool = false
    @State private var showingSheetDetail: Bool = false
    @State private var showingSheetChange: Bool = false
    @State private var selectedWeightChart: WeightChart?
    @State private var weight: String = ""
    
    @State private var showAlertInsert: Bool = false
    @State private var showAlertChange: Bool = false
    
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button(action: {selectedButton = .week}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12.0)
                            .barButtonStyle(selectedButton: selectedButton, buttonType: .week)
                        Text("НЕД")
                            .barTextStyle(selectedButton: selectedButton, buttonType: .week)
                    }
                })
                Divider()
                Button(action: {selectedButton = .month}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12.0)
                            .barButtonStyle(selectedButton: selectedButton, buttonType: .month)
                        Text("MEC")
                            .barTextStyle(selectedButton: selectedButton, buttonType: .month)
                    }
                })
                Divider()
                Button(action: {selectedButton = .sixMonth}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12.0)
                            .barButtonStyle(selectedButton: selectedButton, buttonType: .sixMonth)
                        Text("6 MEC")
                            .barTextStyle(selectedButton: selectedButton, buttonType: .sixMonth)
                            .layoutPriority(1)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .frame(maxWidth: .infinity)
                })
                Divider()
                Button(action: {selectedButton = .year}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12.0)
                            .barButtonStyle(selectedButton: selectedButton, buttonType: .year)
                        Text("ГОД")
                            .barTextStyle(selectedButton: selectedButton, buttonType: .year)
                    }
                })
            }
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 12.0)
                .foregroundStyle(Color("BarMarkBackColor")))
            .padding(.horizontal, 16)
            
            Chart {
                ForEach(filterData) {data in
                    LineMark(x: .value("Date", data.date),
                             y: .value("Weight", data.weight))
                    .symbol(.circle)
                }
                .interpolationMethod(.catmullRom)
            }
            .chartYScale(domain: 0...150)
            .padding()
        }
        .onChange(of: selectedButton) { _ in
            updateFilteredData(for: selectedButton)
        }
        HStack {
            Text("Дата:")
            Text(WeightChart.dateWrapper(data: weightChart))
                .foregroundColor(.secondary)
//            Text("Рост:")
//            Text("182 см")
//                .foregroundColor(.secondary)
            Text("Вес:")
            Text(WeightChart.weightWrapper(data: weightChart))
                .foregroundColor(.secondary)
        }
        .font(.system(size: 14))
        
        Button(action: { showingSheetChange.toggle()}, label: {
            Text("Изменить данные")
                .foregroundStyle(Color("BlueButtonColor"))
                .underline()
        })
        .padding()
        .sheet(isPresented: $showingSheetChange) {
            VStack {
                List(filterData) { data in
                    Button(action: {showingSheetDetail.toggle()
                    selectedWeightChart = data}, label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Вес:")
                                    .foregroundStyle(.backIcon)
                                    .bold()
                                Text("\(data.weight, specifier: "%.2f") кг")
                                    .foregroundStyle(.backIcon)
                            }
                            HStack {
                                Text("Дата:")
                                    .bold()
                                    .foregroundStyle(.backIcon)
                                Text("\(data.date, formatter: dateFormatter)")
                                    .foregroundStyle(.backIcon)
                            }
                        }
                    })
                }
                .sheet(isPresented: $showingSheetDetail, content: {
                    VStack {
                        VStack {
                            DatePicker("",
                                selection: $selectedDate,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(WheelDatePickerStyle()) // Стиль календаря
                            .padding()
                            Text("Выбранная дата: \(selectedDate, formatter: dateFormatter)")
                        }
                        TextField("Введите вес", text: $weight)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Готово") {
                            if let weightFloat = Float(weight), weightFloat > 0 {
                                let mark = WeightChart(weight: weightFloat, date: selectedDate, context: context)
                                PersistenceController.shared.save()
                                showAlertInsert = false
                                showingSheetDetail = false
                            } else {
                                showAlertInsert = true
                            }
                        }
                        .padding()
                    }
                    .presentationDetents([.medium])
                })
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
        
        Button(action: { showingSheetInsert.toggle()}, label: {
            Text("Внести данные")
                .font(.system(size: 15))
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.blue))
        })
        .padding()
        .onReceive(weightChart.publisher) { _ in
            updateFilteredData(for: selectedButton)
        }
        .sheet(isPresented: $showingSheetInsert) {
            VStack {
                VStack {
                    DatePicker("",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(WheelDatePickerStyle()) // Стиль календаря
                    .padding()
                    Text("Выбранная дата: \(selectedDate, formatter: dateFormatter)")
                }
                TextField("Введите вес", text: $weight)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Готово") {
                    if let weightFloat = Float(weight), weightFloat > 0 {
                        let mark = WeightChart(weight: weightFloat, date: selectedDate, context: context)
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
    private func updateFilteredData(for selectButton: SelectButton) {
        switch selectedButton {
        case .week:
            filterData = dataManager.filterDataForWeek(data: weightChart)
        case .month:
            filterData = dataManager.filterDataForMonth(data: weightChart)
        case .sixMonth:
            filterData = dataManager.filterDataForHalfYear(data: weightChart)
        case .year:
            filterData = dataManager.filterDataForYear(data: weightChart)
        }
    }
    
    private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "ru_RU")
    return formatter
    }
}

struct BarButtonModifier: ViewModifier {
    var selectedButton: SelectButton
    var buttonType: SelectButton
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle((selectedButton == buttonType ?
                              Color("BlueButtonColor") : Color("BarMarkBackColor")))
            .frame(height: 29)
    }
}

extension View {
    func barButtonStyle(selectedButton: SelectButton, buttonType: SelectButton) -> some View {
        modifier(BarButtonModifier(selectedButton: selectedButton, buttonType: buttonType))
    }
}

struct BarTextModifier: ViewModifier {
    var selectedButton: SelectButton
    var buttonType: SelectButton
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .foregroundStyle((selectedButton == buttonType ? .white : .black))
            .padding(.horizontal)
    }
}

extension View {
    func barTextStyle(selectedButton: SelectButton, buttonType: SelectButton) -> some View {
        modifier(BarTextModifier(selectedButton: selectedButton, buttonType: buttonType))
    }
}


struct DatePickerView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker("",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(WheelDatePickerStyle()) // Стиль календаря
            .padding()
            Text("Выбранная дата: \(selectedDate, formatter: dateFormatter)")
            Text("Реальная дата:\(selectedDate)")
                .padding()
        }
    }
    private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "ru_RU")
    return formatter
    }
}

#Preview {
    DatePickerView()
}
