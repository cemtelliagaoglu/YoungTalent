//
//  AuthEndpoint.swift
//  YoungTalent
//
//  Created by admin on 18.03.2023.
//

import Foundation

enum AuthEndpoint{
    case login
    case logout
}

extension AuthEndpoint: Endpoint{
    
    public var queryItems: [URLQueryItem]? {
        return nil
    }
    
    public var path: String {
        switch self{
        case .login:
            return "/api/v1/auth/login"
        case .logout:
            return "/api/v1/auth/logout"
        }
    }
    
    public var port: Int{
        return 7076
    }
    
    public var method: RequestMethod {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    public var body: [String : String]? {
        return nil
    }

    public var header: [String: String]? {
        return nil
    }
    
}
