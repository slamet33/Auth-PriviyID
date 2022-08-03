//
//  ProfileRequest.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import Foundation

import Foundation

struct ProfileRequest {
    
    static var shared = ProfileRequest()
    
    var deviceType = Constants.deviceType
    var token = AuthManager.shared.token
}

extension ProfileRequest {
    
    func toParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["device_token"] = AuthManager.shared.getDeviceToken
        dictionary["device_type"] = Constants.deviceType
        return dictionary
    }
    
    func toURLQuery() -> [URLQueryItem] {
        return self.toParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
    func toLogoutParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["confirm"] = 1
        dictionary["access_token"] = token
        return dictionary
    }
    
    func toLogoutURLQuery() -> [URLQueryItem] {
        return self.toLogoutParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
}
