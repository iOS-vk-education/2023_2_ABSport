//
//  MyFormView.swift
//  ABSport
//
//  Created by mac on 15.04.2024.
//

import SwiftUI

struct MyFormView: View {
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .center){
                    Text("Вес")
                    Text("ИМТ")
                }
                HStack(alignment: .center) {
                    Text("Время фиксации:")
                        .font(.subheadline)
                    Text("15:42")
                        .foregroundStyle(Color(.blue))
                }
            }
            ChartsView()
            HStack {
                Text("Дата:")
                Text("04.03.2023")
                Text("Рост")
                Text("182 см")
                Text("Вес")
                Text("76 кг")
            }
            Button(action: {}) {
                Text("Изменить данные")
            }
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
        }
    }
}

#Preview {
    MyFormView()
}
