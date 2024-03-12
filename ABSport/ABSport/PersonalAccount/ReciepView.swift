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
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 150
                    })
            }
            .buttonStyle()
            Button(action: {}) {
                Text("История зказов")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 150
                    })
            }
            .buttonStyle()
            Button(action: {}) {
                Text("Сроки абонемента")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 150
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


struct Test2: View {
    var body: some View {
        VStack {
            Text("Today's Weather")
                .font(.title)
                .alignmentGuide(HorizontalAlignment.center) {_ in 200}
                
                .border(.gray)

            HStack {
                Text("🌧")
                    .alignmentGuide(VerticalAlignment.center) { _ in -20 }
                    .border(.gray)
                Text("Rain & Thunderstorms")
                    .border(.gray)
                Text("⛈")
                    .alignmentGuide(VerticalAlignment.center) { _ in 20 }
                    .border(.gray)
            }
        }
    }
}


struct Test3: View {
    var body: some View {
        VStack(alignment: .leading) {
            
                
            Text("Hello dorn bwei")
                .font(.system(size: 20))
                .foregroundColor(Color("TextColor"))
                .multilineTextAlignment(.leading)
                .padding(.leading, -25.0)
                .frame(width: 180.0)
            Text("Hello dorn bwei")
                .font(.system(size: 20))
                .foregroundColor(Color("TextColor"))
                .multilineTextAlignment(.leading)
                .padding(.leading, -50.0)
                .frame(width: 180.0)
            
        }
    }
}
