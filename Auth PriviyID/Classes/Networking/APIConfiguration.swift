//
//  APIConfiguration.swift
//  Post Here
//
//  Created by Qiarra on 29/08/21.
//

import Foundation

protocol APIConfiguration {
    var baseURL: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var components: URLComponents { get }
    var baseURLType: BaseURLType { get }
    var urlRequest: URLRequest { get }
}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case clientId = "clientId"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case localization = "X-Localization"
    
}

enum BaseURLType: String {
    case baseApiUrlPartner = "BASE_API_URL_PARTNER"
    case baseApiUrlSupport = "BASE_API_URL_SUPPORT"
    case baseApiUrlUnit = "BASE_API_URL_UNIT"
    case baseUrl = "BASE_API_URL"
    case mocking = "MOCK_API"
}

enum ContentType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
}

enum UploadState {
    case uploading(progress: Int)
    case success(url: String)
}

enum DownloadState {
    case downloading(progress: Int)
    case success(url: String)
}

enum HttpMethod: String {
    case post   = "POST"
    case put    = "PUT"
    case get    = "GET"
    case delete = "DELETE"
}

extension URLRequest {
    
    mutating func embedHeaders() {
        addValue(ContentType.form.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        addValue(AuthManager.shared.token, forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        
    }
}
