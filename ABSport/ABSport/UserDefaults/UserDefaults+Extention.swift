//
//  UserDefaults+Extention.swift
//  ABSport
//
//  Created by mac on 21.05.2024.
//

import Foundation

extension UserDefaults {
    static let pushNotificationsEnabledKey = "pushNotificationsEnabled"

    static func setPushNotificationsEnabled(_ isEnabled: Bool) {
        UserDefaults.standard.set(isEnabled, forKey: pushNotificationsEnabledKey)
    }

    static func isPushNotificationsEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: pushNotificationsEnabledKey)
    }
}
