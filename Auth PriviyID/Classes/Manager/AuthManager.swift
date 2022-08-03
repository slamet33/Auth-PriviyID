//
//  AuthManager.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import Foundation
import SwiftKeychainWrapper

// MARK: - - Saving User Data Locally

class AuthManager {
    
    static var shared = AuthManager()
    
    fileprivate let tokenKey            = "tokenKey"
    fileprivate let userId              = "userId"
    fileprivate let phoneKey            = "phoneKey"
    fileprivate let passwordKey         = "passwordKey"
    fileprivate let deviceTokenKey      = "deviceTokenKey"
    fileprivate var keychain            = KeychainWrapper.standard
    
    var isAuth: Bool {
        guard !token.isEmpty else { return false }
        return true
    }
    
    var token: String {
        guard let token = keychain.string(forKey: tokenKey) else { return "" }
        return token
    }
    
    func saveAuth(token: String) {
        keychain.set(token, forKey: tokenKey)
    }
    
    // MARK: UserId
    
    var getUserId: String {
        guard let userId = keychain.string(forKey: userId) else { return "0" }
        return userId
    }
    
    func saveUserId(userId: String) {
        keychain.set(userId, forKey: userId)
    }
    
    // MARK: Device Token
    func saveDeviceToken(token: String) {
        keychain.set(token, forKey: deviceTokenKey)
    }
    
    var getDeviceToken: String {
        guard let token = keychain.string(forKey: deviceTokenKey) else { return "0" }
        return token
    }
    
    func savePhone(phone: String) {
        keychain.set(phone, forKey: phoneKey)
    }
    
    func savePassword(password: String) {
        keychain.set(password, forKey: passwordKey)
    }
    
    func reset() {
        keychain.removeObject(forKey: tokenKey)
    }
    
}
