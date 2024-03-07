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
        VStack(alignment: .leading) {
            Button(action: {}) {
                Text("История аказов")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    
                    
            }
            .buttonStyle()
            Button(action: {}) {
                Text("История аказов")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                   
            }
            .buttonStyle()
            Button(action: {}) {
                Text("Сроки абонемента")
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    
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
                .alignmentGuide(HorizontalAlignment.center) {_ in 100}
                
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
