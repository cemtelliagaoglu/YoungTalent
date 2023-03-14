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
        default:
            return ""
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
        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWJqZWN0IjoiY29tbXVuZS1iZSIsImRldmljZUlEIjoiQ0E0RURFOTYtMUM3MS00RjFDLUI2RjAtRkM4RDhGM0QyRjU2IiwiZXhwaXJhdGlvbiI6MTY4NzQxMzU5Ny41MTk1NzN9.F3Awgk_yLVJfy7pDWkSZFXyUzFdbsUsciWOLuO8TEGNTsi7NYRWDFpitUctCVChUm-tJwlmO4u4aAu2eZSp8TA"
        
        switch self {
        case .currentUser:
            return [
                //"Authorization": "Bearer \(accessToken)",
                "Authorization": "Bearer \(accessToken)",
            ]
        default:
            return nil
        }
    }
    
}

