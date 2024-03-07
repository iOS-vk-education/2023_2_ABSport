//
//  PersonalAccView.swift
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
struct ProfileView: View {
    
    var body: some View {
        VStack {
            ProfileHeaderView()
            ProfileContentView()
            Spacer()
            ProfileFooterView()
        }
        Spacer()
    }
}

struct ProfileHeaderView: View {
    
    let profile = Profile.preview()
    
    var body: some View {
        HStack(alignment: .top, spacing: 29) {
            VStack {
                Image(profile.image)
                    .resizable()
                    .frame(width: 93, height: 93)
                    .clipShape(Circle())
                    
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.name)
                    .font(.system(size: 20))
                    .foregroundColor(Color("TextColor"))
                    .padding(.top, 2)
                Text(profile.date)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                Text(profile.number)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .center) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("SettingsButton")
                        .resizable()
                        .frame(width: 26, height: 26)
                })
            }
            Spacer()
            
        }.offset(x: 32)
    }
}

struct ProfileButtonContent {
    let label: String
    let image: String
    let action: () -> Void
    
    static func preiew() -> [ProfileButtonContent] {
        return [
            ProfileButtonContent(label: "Моя Форма", image: "MusculeSymbol", action: goToMyForm),
            ProfileButtonContent(label: "Списки заказов", image: "PlannerSymbol", action: goToReciep),
            ProfileButtonContent(label: "Мое расписание", image: "ReciepSymbol", action: goToPlanner)]
    }
}

struct ProfileContentView: View {
    
    let buttonContentArray = ProfileButtonContent.preiew()
    var body: some View {
        VStack(alignment: .center) {
            ForEach(buttonContentArray, id: \.label) {buttonContent in
                Button(action: buttonContent.action) {
                    ButtonView(image: buttonContent.image,
                               label: buttonContent.label)
                }
                .foregroundColor(.black) // поверить
                .frame(height: 72)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundColor(Color("LightGreyColor")))
            }
        }
        .padding(.top, 45)
        .padding(.horizontal, 15)
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black) // поверить
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

func goToMyForm() {
    
}

func goToPlanner() {
    
}

func goToReciep() {
    
}

struct ProfileFooterView: View {
    var body: some View {
        HStack {
            Button(action: logOut) {
                Text("Выйти из аккаунта")
                    .font(.system(size: 15))
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(.red))
                    
                    .background(
                                RoundedRectangle(
                                    cornerRadius: 12,
                                    style: .continuous
                                )
                                .stroke(.red, lineWidth: 1)

                            )
            }
            .padding(.horizontal, 15)
            
        }
    }
}

func logOut() {
    
}

struct Test: View {
    var body: some View {
        VStack(alignment: .center) {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    .foregroundColor(.white)
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                            .padding(.horizontal, 10.0))
            })
        }
        
    }
}
#Preview {
    ProfileView()
}
