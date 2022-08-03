//
//  SuccessSignInModel.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import Foundation

struct SuccessSignInModel : Codable {
    
    let data : SuccessSignInData?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}


struct SuccessSignInData : Codable {
    
    let user : SuccessSignInUser?
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
    }
    
}

struct SuccessSignInUser : Codable {
    
    let accessToken : String?
    let tokenType : String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
    
}

