//
//  AppManager.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import Foundation

class AppManager {
    
    static let shared = AppManager()
    
    fileprivate let userDefaults = UserDefaults.standard
    fileprivate let keyRunBefore = "hasRunBefore"
    
    func initial() {
        if !userDefaults.bool(forKey: keyRunBefore) {
            // Remove Keychain items here
            AuthManager.shared.reset()
            // Update the flag indicator
            userDefaults.set(true, forKey: keyRunBefore)
        }
    }
    
}
