//
//  PersonalAccView.swift
//  ABSport
//
//  Created by mac on 06.03.2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack {
            ProfileHeaderView(profileImage: "ProfileImage",
                              profileName: "Михаил Антропов",
                              profileDate: "12.03.1997",
                              profileNumber: "+79254928065")
            ProfileContentView()
            Spacer()
            
        }
        Spacer()
    }
}

struct ProfileHeaderView: View {
    
    let profileImage: String
    let profileName: String
    let profileDate: String
    let profileNumber: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 29) {
            VStack {
                Image(profileImage)
                    .resizable()
                    .frame(width: 93, height: 93)
                    .clipShape(Circle())
                    
            }
            
            VStack(alignment: .leading) {
                Text(profileName)
                    .font(.system(size: 20))
                Text(profileDate)
                Text(profileNumber)
            }
            .offset(y: 15)
            
            Spacer()
            
        }.offset(x: 32)
    }
}

struct ProfileContent {
    let label: String
    let image: String
    
    static func preiew() -> [ProfileContent] {
        return [
            ProfileContent(label: "Моя Форма", image: ""),
            ProfileContent(label: "Списки заказов", image: ""),
            ProfileContent(label: "Мое расписание", image: "")]
    }
}

struct ProfileContentView: View {
    
    @State private var contents: [ProfileContent] = ProfileContent.preiew()
    
    var body: some View {
        List(contents, id: \.label) { row in
            ProfileContentRowView(rowContent: row)
            
        }
    }
}

struct ProfileContentRowView: View {
    let rowContent: ProfileContent
    
    var body: some View {
        HStack {
            VStack {
                Image(rowContent.image)
            }
            VStack {
                Text(rowContent.label)
            }
        }
    }
}

#Preview {
    ProfileView()
}
