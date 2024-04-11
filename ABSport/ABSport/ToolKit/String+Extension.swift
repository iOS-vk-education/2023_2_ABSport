//
//  String+Extension.swift
//  ABSport
//
//  Created by Егор Иванов on 06.03.2024.
//

import Foundation

extension String {
    func formatPhoneNumber(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for char in mask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
                
            } else {
                result.append(char)
            }
        }
        return result
    }
}
