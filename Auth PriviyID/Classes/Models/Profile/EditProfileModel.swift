//
//  EditProfileModel.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import Foundation

struct EditProfileModel : Codable {
    let data : EditProfileData?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct EditProfileData : Codable {
    let user : EditProfileUser?
    enum CodingKeys: String, CodingKey {
        case user = "user"
    }
}

struct EditProfileUser : Codable {
    let id : String?
    let name : String?
    let level : Int?
    let age : Int?
    let birthday : String?
    let gender : String?
    let zodiac : String?
    let hometown : String?
    let bio : String?
    let latlong : String?
    let education : Education?
    let career : Career?
    let user_pictures : [String]?
    let user_picture : String?
    let cover_picture : CoverPicture?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case level = "level"
        case age = "age"
        case birthday = "birthday"
        case gender = "gender"
        case zodiac = "zodiac"
        case hometown = "hometown"
        case bio = "bio"
        case latlong = "latlong"
        case education = "education"
        case career = "career"
        case user_pictures = "user_pictures"
        case user_picture = "user_picture"
        case cover_picture = "cover_picture"
    }
}

struct Education : Codable {
    let school_name : String?
    let graduation_time : String?

    var gradDate: String {
        guard let graduation_time = graduation_time else {
            return ""
        }
        
        guard let date = DatesFormatter.simpleResponse.dateFromString(graduation_time) else {  return "" }
        return DatesFormatter.globalDate.stringFromDate(date)
    }
    enum CodingKeys: String, CodingKey {
        case school_name = "school_name"
        case graduation_time = "graduation_time"
    }
}

struct Career : Codable {
    let company_name : String?
    let starting_from : String?
    let ending_in : String?

    
    var start: String {
        guard let startingFrom = starting_from else {
            return ""
        }
        guard let date = DatesFormatter.simpleResponse.dateFromString(startingFrom) else { return "" }
        return DatesFormatter.globalDate.stringFromDate(date)
    }
    
    var end: String {
        guard let endingIn = ending_in else {
            return ""
        }
        
        guard let date = DatesFormatter.simpleResponse.dateFromString(endingIn) else {  return "" }
        return DatesFormatter.globalDate.stringFromDate(date)
    }
    
    enum CodingKeys: String, CodingKey {
        case company_name = "company_name"
        case starting_from = "starting_from"
        case ending_in = "ending_in"
    }
}

struct CoverPicture : Codable {
    let url : String?

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}
