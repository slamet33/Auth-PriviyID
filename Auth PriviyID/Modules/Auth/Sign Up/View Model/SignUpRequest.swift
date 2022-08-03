//
//  SignUpRequest.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import Foundation

struct SignUpRequest {
    
    static var shared = SignUpRequest()
    
    var phone: String = ""
    var password: String = ""
    var country: String = ""
    var latLong: String = ""
    var deviceToken = ""
    var deviceType = Constants.deviceType
}

extension SignUpRequest {
    
    func toParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["phone"] = phone
        dictionary["password"] = password
        dictionary["country"] = country
        dictionary["latlong"] = latLong
        dictionary["device_token"] = AuthManager.shared.getDeviceToken
        dictionary["device_type"] = Constants.deviceType
        return dictionary
    }
    
    func toOTPParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["phone"] = phone
        return dictionary
    }
    
    func toURLQuery() -> [URLQueryItem] {
        return self.toParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
    func toURLOTPQuery() -> [URLQueryItem] {
        return self.toOTPParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
}
