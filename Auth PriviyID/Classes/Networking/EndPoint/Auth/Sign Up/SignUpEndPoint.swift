//
//  SignUpEndPoint.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import Foundation

enum SignUpEndPoint: APIConfiguration {
    
    case doRegister(request: SignUpRequest)
    case otp(request: SignUpRequest)
    case request(request: OTPRequest)
    case matchOtp(request: OTPRequest)
    
    // MARK: --Path
    internal var path: String {
        switch self {
        case .doRegister:
            return "register"
        case .otp:
            return "register/otp/request"
        case .request:
            return "register/otp/request"
        case .matchOtp:
            return "register/otp/match"
        }
    }
    
    var baseURLType: BaseURLType {
        switch self {
        case .doRegister, .otp, .matchOtp, .request:
            return .baseUrl
        }
    }
    
    // MARK: - - BaseURL with Path Components
    internal var baseURL: URL {
        var url: URL!
        
        switch baseURLType {
        case .baseUrl:
            url = URL(string: Environment.baseApiURL)
        default:
            url = URL(string: Environment.baseApiURL)
        }
        
        let baseURL = url.appendingPathComponent(path)
        return baseURL
    }
    
    // MARK: - - Query Items / Parameters
    internal var queryItems: [URLQueryItem]? {
        let query = components.queryItems
        return query
    }
    
    // MARK: - - URL Components / Parameters
    internal var components: URLComponents {
        
        guard var components =  URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Couldn't create URLComponents")
        }
        
        switch self {
        case .doRegister(let request):
            components.queryItems = request.toURLQuery()
        case .otp(let request):
            components.queryItems = request.toURLOTPQuery()
        case .matchOtp(let request):
            components.queryItems = request.toURLQuery()
        case .request(let request):
            components.queryItems = request.toOTPResendURLQuery()
        }
        
        return components
    }
    
    // MARK: - - URL Request
    var urlRequest: URLRequest {
        var request = URLRequest(url: components.url!)
        request.embedHeaders()
        switch self {
        case .doRegister, .otp, .matchOtp, .request:
            request.httpMethod = HttpMethod.post.rawValue
        }
        
        return request
    }
}

