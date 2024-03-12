//
//  ReciepView.swift
//  ABSport
//
//  Created by mac on 07.03.2024.
//

import Foundation
import SwiftUI

struct ReciepView: View {
    var body: some View {
        ReciepButtonView()
        Spacer()
        
    }
}

struct ReciepButtonView: View {
    var body: some View {
        VStack(alignment: .center) {
            Button(action: {}) {
                Text("История аказов")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 142
                    })
            }
            .buttonStyle()
            Button(action: {}) {
                Text("История зказов")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 142
                    })
            }
            .buttonStyle()
            Button(action: {}) {
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

#Preview {
    ReciepView()
}
