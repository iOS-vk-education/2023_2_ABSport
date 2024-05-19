//
//  FirebaseDay.swift
//  ABSport
//
//  Created by Александр Бобрун on 17.05.2024.
//

import Foundation

struct FirebaseDay: Identifiable, Codable  {
    var id: String
    var date: Date // or String
    var users: [FirebaseUser] // or [String] with ids
    var trainers: [FirebaseTrainer] // or [String] with ids
}
