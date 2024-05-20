//
//  FirebaseUser.swift
//  ABSport
//
//  Created by Александр Бобрун on 17.05.2024.
//

import Foundation

struct FirebaseUser: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
//    var reservations: [FirebaseReservation] // or [String] with ids
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension FirebaseUser {
    static var mockUser = FirebaseUser(id: NSUUID().uuidString, fullName: "Michael Jordan", email: "test@mail.ru")
}
