//
//  LoginView.swift
//  ABSport
//
//  Created by mac on 16.05.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var isPresented: Bool = true
    @EnvironmentObject var viewModel: AuthViewModel
    var regisrtAction: () -> Void
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Image("LogoImage")
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .ignoresSafeArea()
                    .foregroundStyle(Color.white)
                SheetLoginView(viewModel: viewModel, registrRequested: regisrtAction)
            }
            //.frame(height: UIScreen.main.bounds.height / 2)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LoadColor"))
    }
}

struct SheetLoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject var viewModel: AuthViewModel
    var registrRequested: () -> Void
  
    var body: some View {
        VStack {
            Text("Вход")
                .bold()
                .font(.title)
                .padding()
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Электронная почта")
                    TextField("", text: $email)
                        .padding()
                        .frame(height: 40)
                        .textInputAutocapitalization(.never)
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
                    SecureField("", text: $password)
                        .padding()
                        .frame(height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 12.0)
                                .stroke(Color("DarkGrayColor"), lineWidth: 1)
                                .foregroundStyle(Color("LightGreyColor")))
                }
                .padding(.horizontal, 34)
            }
            
            Spacer()
            
            Button {
                Task {
                    try await viewModel.signInApp(withEmail: email, password: password)
                }
            } label: {
                Text("Войти")
            }
            .foregroundStyle(Color(.white))
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(Color("BlueButtonColor")))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .padding(.horizontal, 34)
            
            Spacer()
            
            Button(action: registrRequested, label: {
                Text("Нет аккаунта?")
                    .foregroundStyle(Color("RunningTrainingColor"))
                Text("Регистрация")
                    .foregroundStyle(Color("RunningTrainingColor"))
                    .bold()
            })
        }
    }
}

extension SheetLoginView: AutentificationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView(regisrtAction: {})
}
