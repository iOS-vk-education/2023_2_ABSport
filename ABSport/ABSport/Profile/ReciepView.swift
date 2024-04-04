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
        ReciepButtonView()
        Spacer()
    }
}

struct ReciepButtonView: View {
    var body: some View {
        VStack(alignment: .center) {
            Button(action: goToHistoryOrder) {
                Text("История аказов")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 142
                    })
            }
            .buttonStyle()
            Button(action: goToHistoryOrder) {
                Text("История зказов")
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
