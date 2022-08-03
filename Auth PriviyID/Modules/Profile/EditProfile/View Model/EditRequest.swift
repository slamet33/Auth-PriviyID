//
//  EditRequest.swift
//  Auth PriviyID
//
//  Created by Qiarra on 07/09/21.
//

import Foundation

struct EditProfileRequest {
    
    static var shared = EditProfileRequest()
    
    var deviceType = Constants.deviceType
    
    // MARK: BIO
    var name = ""
    var gender = 0
    var birthDay = ""
    var homeTown = ""
    var bio = ""
    
    // MARK: Education
    var schoolName = ""
    var graduatedTime = ""
    
    // MARK: Carrer
    var position = ""
    var companyName = ""
    var startDate = ""
    var endDate = ""
    
    let genderData = [ChoiseData(id: 0, name: "Male"), ChoiseData(id: 1, name: "Female")]
    var selectedIndex = 0
}

extension EditProfileRequest {
    
    func toCarrerParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["position"] = position
        dictionary["company_name"] = companyName
        dictionary["starting_from"] = startDate
        dictionary["ending_in"] = endDate
        return dictionary
    }
    
    func toCarrerURLQuery() -> [URLQueryItem] {
        return self.toCarrerParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
    func toEducationParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["school_name"] = schoolName
        dictionary["graduation_time"] = graduatedTime
        return dictionary
    }
    
    func toEducationURLQuery() -> [URLQueryItem] {
        return self.toEducationParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
    func toBioParameters() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["name"] = name
        dictionary["gender"] = gender
        dictionary["birthday"] = birthDay
        dictionary["gender"] = gender
        dictionary["hometown"] = homeTown
        dictionary["bio"] = bio
        return dictionary
    }
    
    func toBioURLQuery() -> [URLQueryItem] {
        return self.toBioParameters().map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
    
}
