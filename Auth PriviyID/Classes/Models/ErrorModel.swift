//
//  ErrorModel.swift
//  Post Here
//
//  Created by Qiarra on 29/08/21.
//

import Foundation

// MARK: - ErrorModel
struct ErrorResponse : Codable {
    
    let error : ErrorModel?
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
    
}

struct ErrorModel : Codable {
    
    let code : Int?
    let errors : [String]?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case errors = "errors"
    }

}
