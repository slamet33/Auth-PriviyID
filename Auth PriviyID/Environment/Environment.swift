//
//  Environment.swift
//  Auth PriviyID
//
//  Created by Qiarra on 04/09/21.
//

import Foundation

private enum ConfigKeys: String {
    case appName = "APP_NAME"
    case appBundleID = "APP_BUNDLE_ID"
    case appVersion = "APP_VERSION"
    case baseApiURL = "BASE_API_URL"
}

fileprivate final class PlistUtils {
    
    private init() {}
    
    static func getValue(from key: ConfigKeys) -> String {
        
        guard let info = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        
        guard let value = info[key.rawValue] as? String else {
            fatalError("\(key)'s not set in plist file")
        }
        
        return value
    }
    
}

internal enum Environment {
    
    static let appName = PlistUtils.getValue(from: ConfigKeys.appName)
    static let appVersion = PlistUtils.getValue(from: ConfigKeys.appVersion)
    static let appBundleID = PlistUtils.getValue(from: ConfigKeys.appBundleID)
    static let baseApiURL = PlistUtils.getValue(from: ConfigKeys.baseApiURL)
    static let mockServer = "https://private-anon-f9fabb5cb9-roommeapi.apiary-mock.com/"
    
}
