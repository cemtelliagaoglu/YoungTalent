//
//  UserEndpoint.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

public enum UserEndpoint{
    case currentUser
    case allUsers
}

extension UserEndpoint: Endpoint {
    
    public var queryItems: [URLQueryItem]? {
        return nil
    }
    
    public var path: String {
        switch self {
        case .currentUser:
            return "/api/v1/auth/me"
        case .allUsers:
            return "/api/v1/auth"
        }
    }
    
    public var port: Int{
        return 7076
    }
    
    public var method: RequestMethod {
        switch self {
        case .currentUser:
            return .get
        default:
            return .get
        }
    }
    
    public var body: [String : String]? {
        return nil
    }

    public var header: [String: String]? {
        // TODO: Access Token to use in Bearer header, could be get and set via Singleton Keychain Manager
        guard let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String else{ return nil }
        
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
}

