//
//  OTPRequest.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import Foundation

struct OTPRequest {
    
    static var shared = OTPRequest()
    
    var userId: String = ""
    var otp: String = ""
    
    var phone: String = ""
}

extension OTPRequest {
    
    func toParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["user_id"] = userId
        dictionary["otp_code"] = otp
        return dictionary
    }
    
    func toURLQuery() -> [URLQueryItem] {
        return self.toParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
    func toOTPResendParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["phone"] = phone
        return dictionary
    }
    
    func toOTPResendURLQuery() -> [URLQueryItem] {
        return self.toOTPResendParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
}
