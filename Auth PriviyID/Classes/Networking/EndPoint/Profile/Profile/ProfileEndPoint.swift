//
//  ProfileEndPoint.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import Foundation

enum ProfileEndPoint: APIConfiguration {
    
    case profile
    case logout(request: ProfileRequest)
    
    // MARK: --Path
    internal var path: String {
        switch self {
        case .profile:
            return "profile/me"
        case .logout:
            return "oauth/revoke"
        }
    }
    
    var baseURLType: BaseURLType {
        switch self {
        case .profile, .logout:
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
        case .profile: break
        case .logout(let request):
            components.queryItems = request.toLogoutURLQuery()
        }
        
        return components
    }
    
    // MARK: - - URL Request
    var urlRequest: URLRequest {
        var request = URLRequest(url: components.url!)
        request.embedHeaders()
        switch self {
        case .profile:
            request.httpMethod = HttpMethod.get.rawValue
        case .logout:
            request.httpMethod = HttpMethod.post.rawValue
        }
        
        return request
    }
}
