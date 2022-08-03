//
//  SignInEndPoint.swift
//  Post Here
//
//  Created by Qiarra on 31/08/21.
//

import Foundation

enum SignInEndPoint: APIConfiguration {
    
    case doLogin(request: SignInRequest)
    
    // MARK: --Path
    internal var path: String {
        switch self {
        case .doLogin:
            return "oauth/sign_in"
        }
    }
    
    var baseURLType: BaseURLType {
        switch self {
        case .doLogin:
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
        case .doLogin(let request):
            components.queryItems = request.toURLQuery()
            break
        }
        
        return components
    }
    
    // MARK: - - URL Request
    var urlRequest: URLRequest {
        var request = URLRequest(url: components.url!)
        request.embedHeaders()
        switch self {
        case .doLogin:
            request.httpMethod = HttpMethod.post.rawValue
        }
        
        return request
    }
}
