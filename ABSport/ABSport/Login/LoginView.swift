//
//  LoginView.swift
//  ABSport
//
//  Created by mac on 16.05.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var isPresented: Bool = true
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Image("LogoImage")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LoadColor"))
        .sheet(isPresented: $isPresented, content: {
            SheetLoginView()
                .presentationDetents([.medium])
        })
    }
}

struct SheetLoginView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack {
            Text("Вход")
                .bold()
                .font(.title)
                .padding()
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Логин / номер телефона")
                    TextField("    +7 777 777 7777", text: $login)
                        .frame(height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                                .stroke(Color("DarkGrayColor"), lineWidth: 1)
                                .foregroundStyle(Color("LightGreyColor")))
                }
                .padding(.horizontal, 34)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Пароль")
                    TextField("    ********", text: $password)
                        .frame(height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                                .stroke(Color("DarkGrayColor"), lineWidth: 1)
                                .foregroundStyle(Color("LightGreyColor")))
                }
                .padding(.horizontal, 34)
            }
            HStack(alignment: .bottom) {
                Button(action: {}, label: {
                    RoundedRectangle(cornerRadius: 6.0)
                        .frame(width: 20, height: 20)
                        .background(RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color("DarkGrayColor"))
                            .foregroundStyle(Color("LightGreyColor"))
                            .frame(width: 28, height: 28))
                })
                Text("Запомнить меня")
                Spacer()
            }
            .padding(.horizontal, 34)
            .padding(.vertical)
            
            Spacer()
            
            Button(action: {}, label: {
                Text("Войти")
            })
            .foregroundStyle(Color(.white))
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(Color("BlueButtonColor")))
            .padding(.horizontal, 34)
            
            Spacer()
            
            Button(action: {}, label: {
                Text("Забыли пароль?")
                    .foregroundStyle(Color("RunningTrainingColor"))
                    .underline()
            })
        }
    }
}

#Preview {
    LoginView()
}
