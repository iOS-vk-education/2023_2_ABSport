//
//  ReciepView.swift
//  ABSport
//
//  Created by mac on 07.03.2024.
//

import Foundation
import SwiftUI

// MARK: - Reciep View
struct ReciepView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack {
                ReciepButtonView()
                Spacer()
            }
        }
    }
}

struct ReciepButtonView: View {
    var body: some View {
        VStack(alignment: .center) {
            Button(action: goToHistoryOrder) {
                Text("История записи")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 142
                    })
            }
            .buttonStyle()
            Button(action: goToHistoryOrder) {
                Text("История заказов")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 142
                    })
            }
            .buttonStyle()
            Button(action: goToSeasonTicket) {
                Text("Сроки абонемента")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 142
                    })
            }
            .buttonStyle()
        }
        .navigationBarTitle("Списки заказов")
        .padding(15)
    }
}

// MARK: - Button Function
func goToHistoryOrder() {
    
}

func goToSeasonTicket() {
    
}
#Preview {
    ReciepView()
}
