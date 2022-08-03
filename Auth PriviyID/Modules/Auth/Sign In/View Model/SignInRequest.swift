//
//  SignInRequest.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import Foundation

struct SignInRequest {
    
    static var shared = SignInRequest()
    
    var phone: String = ""
    var password: String = ""
    var latLong: String = ""
    var deviceToken = ""
    var deviceType = Constants.deviceType
}

extension SignInRequest {
    
    func toParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["phone"] = phone
        dictionary["password"] = password
        dictionary["latlong"] = latLong
        dictionary["device_token"] = AuthManager.shared.getDeviceToken
        dictionary["device_type"] = Constants.deviceType
        return dictionary
    }
    
    func toURLQuery() -> [URLQueryItem] {
        return self.toParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
}
