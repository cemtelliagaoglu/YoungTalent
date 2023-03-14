//
//  GroupsEndpoint.swift
//  YoungTalent
//
//  Created by admin on 10.03.2023.
//

import Foundation

public enum GroupsEndpoint {
    case all
    case myGroups
    case userGroups
}

extension GroupsEndpoint: Endpoint {
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .all:
            return nil
//            return [URLQueryItem(name: "page", value: "1"),
//                    URLQueryItem(name: "per", value: "5")]
        default:
            return nil
        }
    }
    
    public var path: String {
        switch self {
        case .all:
            return "/api/v1/groups"
        default:
            return ""
        }
    }
    
    public var port: Int{
        return 7076
    }
    
    public var method: RequestMethod {
        switch self {
        case .all:
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
        case .all:
            return [
                //"Authorization": "Bearer \(accessToken)",
                "Authorization": "Bearer \(accessToken)",
            ]
        default:
            return nil
        }
    }
    
}
