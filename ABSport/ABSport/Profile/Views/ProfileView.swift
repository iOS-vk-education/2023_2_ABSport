//
//  Profile.swift
//  ABSport
//
//  Created by mac on 06.03.2024.
//

import Foundation
import SwiftUI

struct Profile {
    let name: String
    let image: String
    let date: String
    let number: String
    
    static func preview() -> Profile {
        return Profile(name: "Михаил Антропов",
                       image: "ProfileImage",
                       date: "12.03.1997",
                       number: "+7 925 492 80 65")
    }
}
// MARK: - Profile View
struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var settingsAction: () -> Void
    var myFormAction: () -> Void
    var reciepAction: () -> Void
    var plannerAction: () -> Void
    var logoutAction: () -> Void
    
    var body: some View {
        if let user = viewModel.curentUser {
            ZStack {
                Color("BackgroundColor")
                VStack(spacing: 0) {
                    ProfileHeaderView(user: user)
                    ProfileContentView(contentRequested: (myFormAction, settingsAction))
                    Spacer()
                    ProfileFooterView(viewModel: viewModel, logoutRequested: logoutAction)
                }
            }
            .navigationTitle("Профиль")
        }
    }
}

struct ProfileHeaderView: View {
    
    let user: FirebaseUser
    
    var body: some View {
        HStack(alignment: .center, spacing: 29) {
//            Image(profile.image)
//                .resizable()
//                .frame(width: 93, height: 93)
//                .clipShape(Circle())
            Text(user.initials)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Color.white)
                .frame(width: 93, height: 93)
                .background(Color(.systemGray3))
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 10) {
                Text(user.fullName)
                    .font(.system(size: 20))
                    .foregroundColor(Color("NameColor"))
                    .padding(.top, 2)
//                Text(profile.date)
//                    .font(.system(size: 14))
//                    .foregroundColor(.secondary)
                Text(user.email)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

struct ProfileContentView: View {
    // swiftlint:disable large_tuple
    var contentRequested: (myForm: () -> Void,
                          settings: () -> Void)
    // swiftlint:enable large_tuple
    var body: some View {
        VStack(alignment: .center) {
            Button(action: contentRequested.myForm) {
                ButtonView(image: "MusculeSymbol", label: "Моя Форма")
            }
            .buttonStyle()
            Button(action: contentRequested.settings) {
                ButtonView(image: "SettingsButton", label: "Настройки")
            }
            .buttonStyle()
        }
        .padding(.horizontal, 15)
    }
}

struct ButtonView: View {
    
    let image: String
    let label: String
    var body: some View {
        HStack {
            VStack {
                Image(image)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 23)
            VStack {
                Text(label)
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
            }
            Spacer()
        }
    }
}

struct ProfileFooterView: View {
    var viewModel: AuthViewModel
    var logoutRequested: () -> Void
    
    var body: some View {
        HStack {
            Button {
                viewModel.signOut()
                //logoutRequested()
            } label: {
                Text("Выйти из аккаунта")
                    .font(.system(size: 15))
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(.red))
                    
                    .background(
                                RoundedRectangle(
                                    cornerRadius: 12,
                                    style: .continuous)
                                .stroke(.red, lineWidth: 1))
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
}

// MARK: - View Modifier
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .frame(height: 72)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundColor(Color("LightGreyColor")))
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(ButtonModifier())
    }
}

// #Preview {
//    ProfileView(actionRequested: {})
// }
