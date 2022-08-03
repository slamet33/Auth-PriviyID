//
//  RegisterModel.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import Foundation

struct RegisterModel : Codable {
    
    let data : RegisterModelData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct RegisterModelData : Codable {
    
    let user : RegisterModelUser?
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
    }
}

struct RegisterModelUser : Codable {
    
    let country : String?
    let id : String?
    let latlong : [[String: String]]?
    let phone : String?
    let sugarId : String?
    let userDevice : RegisterModelUserDevice?
    let userStatus : String?
    let userType : String?
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case id = "id"
        case latlong = "latlong"
        case phone = "phone"
        case sugarId = "sugar_id"
        case userDevice = "user_device"
        case userStatus = "user_status"
        case userType = "user_type"
    }
}

struct RegisterModelUserDevice : Codable {
    
    let deviceStatus : String?
    let deviceToken : String?
    let deviceType : String?
    
    enum CodingKeys: String, CodingKey {
        case deviceStatus = "device_status"
        case deviceToken = "device_token"
        case deviceType = "device_type"
    }
}
