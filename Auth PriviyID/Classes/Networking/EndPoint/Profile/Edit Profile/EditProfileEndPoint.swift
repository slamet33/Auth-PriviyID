//
//  EditProfileEndPoint.swift
//  Auth PriviyID
//
//  Created by Slamet Riyadi on 04/08/22.
//

import Foundation

enum EditProfileEndPoint: APIConfiguration {
    
    case editCarrer(request: EditProfileRequest)
    case editEducation(request: EditProfileRequest)
    case editBio(request: EditProfileRequest)
    
    // MARK: --Path
    internal var path: String {
        switch self {
        case .editCarrer:
            return "profile/career"
        case .editEducation:
            return "profile/education"
        case .editBio:
            return "profile"
        }
    }
    
    var baseURLType: BaseURLType {
        switch self {
        case .editCarrer, .editEducation, .editBio:
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
        case .editCarrer(let request):
            components.queryItems = request.toCarrerURLQuery()
        case .editEducation(let request):
            components.queryItems = request.toEducationURLQuery()
        case .editBio(let request):
            components.queryItems = request.toBioURLQuery()
        }
        
        return components
    }
    
    // MARK: - - URL Request
    var urlRequest: URLRequest {
        var request = URLRequest(url: components.url!)
        request.embedHeaders()
        switch self {
        case .editEducation, .editBio, .editCarrer:
            request.httpMethod = HttpMethod.post.rawValue
//        case .editCarrer(let param):
//            request.httpMethod = HttpMethod.post.rawValue
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//            if let httpBody = try? JSONSerialization.data(withJSONObject: param.toCarrerParameters(), options: []) {
//                request.httpBody = httpBody
//            }
        }
        
        return request
    }
}
