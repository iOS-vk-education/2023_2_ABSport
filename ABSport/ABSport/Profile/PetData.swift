//
//  PetData.swift
//  ABSport
//
//  Created by mac on 14.04.2024.
//

import Foundation

struct PetData: Identifiable, Equatable {
    let type: String
    let count: Float
    
    var id: String {return type}
    
    static var backData: [PetData] {
        [PetData(type: "Mon", count: 100.0),
         PetData(type: "Tue", count: 100.0),
         PetData(type: "Wed", count: 100.0),
         PetData(type: "Thu", count: 100.0),
         PetData(type: "Fri", count: 100.0),
         PetData(type: "Sat", count: 100.0),
         PetData(type: "Sun", count: 100.0)]
    }
    
    static var data: [PetData] {
        [PetData(type: "Mon", count: 50.0),
                    PetData(type: "Tue", count: 55.5),
                    PetData(type: "Wed", count: 60.0),
                    PetData(type: "Thu", count: 55.0),
                    PetData(type: "Fri", count: 52.5),
                    PetData(type: "Sat", count: 60.0),
                    PetData(type: "Sun", count: 43.0)]
    }
}
