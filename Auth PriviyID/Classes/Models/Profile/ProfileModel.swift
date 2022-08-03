//
//  ProfileModel.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import Foundation

struct ProfileModel : Codable {
    
    let data : ProfileModelData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct ProfileModelData : Codable {
    
    let user : ProfileModelUser?
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
    }
    
}

struct ProfileModelUser : Codable {
    
    let age : Int?
    let bio : String?
    let birthday : Date?
    let career : ProfileModelCareer?
    let coverPicture : ProfileModelCoverPicture?
    let education : ProfileModelEducation?
    let gender : Int?
    let hometown : String?
    let id : String?
    let latlong : String?
    let level : Int?
    let name : String?
    let userPicture : String?
    let userPictures : [String]?
    let zodiac : String?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case bio = "bio"
        case birthday = "birthday"
        case career = "career"
        case coverPicture = "cover_picture"
        case education = "education"
        case gender = "gender"
        case hometown = "hometown"
        case id = "id"
        case latlong = "latlong"
        case level = "level"
        case name = "name"
        case userPicture = "user_picture"
        case userPictures = "user_pictures"
        case zodiac = "zodiac"
    }
}

struct ProfileModelEducation : Codable {
    
    let graduationTime : Date?
    let schoolName : String?
    
    enum CodingKeys: String, CodingKey {
        case graduationTime = "graduation_time"
        case schoolName = "school_name"
    }
    
}

struct ProfileModelCoverPicture : Codable {
    
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}

struct ProfileModelCareer : Codable {
    
    let companyName : String?
    let endingIn : Date?
    let startingFrom : Date?
    
    var start: String {
        guard let startingFrom = startingFrom else {
            return ""
        }
        
        return DatesFormatter.simpleResponseSlash.stringFromDate(startingFrom)
    }
    
    var end: String {
        guard let endingIn = endingIn else {
            return ""
        }
        
        return DatesFormatter.simpleResponseSlash.stringFromDate(endingIn)
    }
    
    enum CodingKeys: String, CodingKey {
        case companyName = "company_name"
        case endingIn = "ending_in"
        case startingFrom = "starting_from"
    }
    
}
