//
//  RegistrationView.swift
//  ABSport
//
//  Created by mac on 19.05.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var fullName: String = ""
    
    var loginAction: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Image("LogoImage")
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .ignoresSafeArea()
                    .foregroundStyle(Color.white)
                VStack {
                    Text("Регистрация")
                        .bold()
                        .font(.title)
                        .padding()

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Полное имя")
                            TextField("", text: $fullName)
                                .padding()
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
                            Text("Электронная почта")
                            TextField("", text: $email)
                                .padding()
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
                            SecureField("Введите пароль", text: $password)
                                .padding()
                                .textContentType(nil)
                                .frame(height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 12.0)
                                        .stroke(Color("DarkGrayColor"), lineWidth: 1)
                                        .foregroundStyle(Color("LightGreyColor")))
                        }
                        .padding(.horizontal, 34)
                    }
                    ZStack(alignment: .trailing) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Проверка пароля")
                                SecureField("Введите пароль", text: $confirmPassword)
                                    .padding()
                                    .textContentType(nil)
                                    .frame(height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12.0)
                                            .stroke(Color("DarkGrayColor"), lineWidth: 1)
                                            .foregroundStyle(Color("LightGreyColor")))
                            }
                            
                        }
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .bold()
                                    .foregroundStyle(Color(.systemGreen))
                                    .padding(.top, 30)
                                    .padding(.trailing, 10)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .bold()
                                    .foregroundStyle(Color(.systemRed))
                                    .padding(.top, 30)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                    .padding(.horizontal, 34)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            try await viewModel.createUser(withEmail: email,
                                                           password: password,
                                                           fullName: fullName)
                        }
                    }label: {
                        Text("Зарегистрироваться")
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
                    
                    Button(action: loginAction, label: {
                        Text("Уже есть аккаунт?")
                            .foregroundStyle(Color("RunningTrainingColor"))
                        Text("Войти")
                            .foregroundStyle(Color("RunningTrainingColor"))
                            .bold()
                    })
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LoadColor"))
    }
}

extension RegistrationView: AutentificationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullName.isEmpty
        && confirmPassword == password
    }
}

#Preview {
    RegistrationView(loginAction: {})
}
