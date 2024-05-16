//
//  FirebaseReservation.swift
//  ABSport
//
//  Created by Александр Бобрун on 17.05.2024.
//

import Foundation

struct FirebaseReservation {
    var id: String
    var type: String
    var trainerId: String?
    var userId: String
    var startDate: Date // or String
    var endDate: Date // or String
}
