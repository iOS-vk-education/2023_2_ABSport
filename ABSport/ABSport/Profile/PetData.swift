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
    
    static var dataWeight: [PetData] {
        [PetData(type: "Mon", count: 50.0),
        PetData(type: "Tue", count: 55.5),
        PetData(type: "Wed", count: 60.0),
        PetData(type: "Thu", count: 55.0),
        PetData(type: "Fri", count: 52.5),
        PetData(type: "Sat", count: 60.0),
        PetData(type: "Sun", count: 43.0)]
    }
    
    static var dataMuscles: [PetData] {
        [PetData(type: "Mon", count: 15.0),
         PetData(type: "Tue", count: 20.0),
         PetData(type: "Wed", count: 10.0),
         PetData(type: "Thu", count: 30.0),
         PetData(type: "Fri", count: 12.0),
         PetData(type: "Sat", count: 25.0),
         PetData(type: "Sun", count: 35.0)]
    }
    
    static var dataFat: [PetData] {
        [PetData(type: "Mon", count: 45.0),
         PetData(type: "Tue", count: 40.0),
         PetData(type: "Wed", count: 30.0),
         PetData(type: "Thu", count: 50.0),
         PetData(type: "Fri", count: 32.0),
         PetData(type: "Sat", count: 45.0),
         PetData(type: "Sun", count: 55.0)]
    }
    
    static var dataWater: [PetData] {
        [PetData(type: "Mon", count: 40.0),
         PetData(type: "Tue", count: 40.0),
         PetData(type: "Wed", count: 60.0),
         PetData(type: "Thu", count: 20.0),
         PetData(type: "Fri", count: 56.0),
         PetData(type: "Sat", count: 30.0),
         PetData(type: "Sun", count: 10.0)]
    }
}
