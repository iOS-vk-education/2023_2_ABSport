//
//  SettingsView.swift
//  ABSport
//
//  Created by mac on 12.03.2024.
//

import Foundation
import SwiftUI

struct SettingsList: Identifiable {
    let id: UUID
    var title: String
    var subtitle: String
    var isOn: Bool
    
    static func preview() -> [SettingsList] {
        return [
            SettingsList(id: UUID(),
                         title: "СМС уведомления",
                         subtitle: "Включите данную функцию, чтобы получать СМС уведомления.",
                         isOn: true),
            SettingsList(id: UUID(),
                         title: "Push уведомления",
                         subtitle: "Включите данную функцию, чтобы получать Push уведомления.",
                         isOn: true),
            SettingsList(id: UUID(),
                         title: "Email рассылка",
                         subtitle: "Включите данную функцию, чтобы подписаться на email рассылку.",
                         isOn: true)
        ]
    }
}

struct SettingsView: View {
    
    //var deleteRequested: () -> Void
    @EnvironmentObject var viewModel: AuthViewModel
    @State var settingsLists = SettingsList.preview()
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack {
                VStack {
                    ForEach($settingsLists) { $list in
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text(list.title)
                                    .font(.headline)
                                Text(list.subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }.layoutPriority(1)
                            VStack {
                                Toggle("", isOn: $list.isOn)
                                    .onChange(of: list.isOn) { newValue in
                                        if list.title == "Push уведомления" {
                                            UserDefaults.setPushNotificationsEnabled(newValue)
//                                            if newValue {
//                                                addNotification(time: 5, title: "Тестовое уведомление", subtitle: "", body: "Push уведомления включены!")
//                                            }
                                        }
                                    }
                            }
                        }.padding()
                    }
                }
                Spacer()
                SettingsFooterView(viewModel: viewModel)
            }
            
        }
        .navigationBarTitle("Настройки")
        .onAppear {
            if let index = settingsLists.firstIndex(where: { $0.title == "Push уведомления" }) {
                settingsLists[index].isOn = UserDefaults.isPushNotificationsEnabled()
            }
        }
    }
}

struct SettingsFooterView: View {
    
    var viewModel: AuthViewModel
    
    var body: some View {
        HStack {
            Button{
                Task {
                    await viewModel.deleteAccountc()
                }
            }label: {
                Text("Удалить аккаунт")
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
#Preview {
    SettingsView()
}
