//
//  MyFormView.swift
//  ABSport
//
//  Created by mac on 15.04.2024.
//

import SwiftUI

struct MyFormView: View {
    
    @State private var isShowingFirstChart = true
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .center){
                    Button(action: {
                        self.isShowingFirstChart = true
                    }) {
                        Text("Вес")
                            .foregroundColor(isShowingFirstChart ? Color("BlueButtonColor") : .black)
                            .underline(isShowingFirstChart)
                    }
                    .padding()
                    Button(action: {
                        self.isShowingFirstChart = false
                    }) {
                        Text("ИМТ")
                            .foregroundColor(isShowingFirstChart ? .black : Color("BlueButtonColor"))
                            .underline(!isShowingFirstChart)
                    }
                    .padding()
                }
                HStack(alignment: .center) {
                    Text("Время фиксации:")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    Text("15:42")
                        .font(.system(size: 14))
                        .foregroundStyle(Color("BlueButtonColor"))
                }
            }
            if isShowingFirstChart {
                ChartsViewWeight()
            } else {
                ChartsViewIMT()
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
            
            Button(action: {}) {
                Text("Изменить данные")
                    .foregroundStyle(Color("BlueButtonColor"))
                    .underline()
            }
            .padding()
            Spacer()
            Button(action: {}) {
                Text("Внести данные")
                    .font(.system(size: 15))
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(.white))
                    .background(
                                RoundedRectangle(
                                    cornerRadius: 12)
                                .foregroundColor(.blue))
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    MyFormView()
}
