//
//  MyFormView.swift
//  ABSport
//
//  Created by mac on 15.04.2024.
//

import SwiftUI

struct MyFormView: View {
    
    @State private var isShowingFirstChart = true
    @State private var showingSheet: Bool = false
    @State private var weight: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .center) {
                    Button(action: {
                        self.isShowingFirstChart = true
                    }){
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
            }
            if isShowingFirstChart {
                Weight()
            } else {
                ChartsViewIMT()
            }
        }
        .navigationTitle("Моя форма")
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
}

#Preview {
    MyFormView()
}
