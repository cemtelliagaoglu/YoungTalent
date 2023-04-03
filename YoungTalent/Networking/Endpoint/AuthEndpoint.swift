//
//  AuthEndpoint.swift
//  YoungTalent
//
//  Created by admin on 18.03.2023.
//

import Foundation

enum AuthEndpoint {
    case login(String, String)
    case refresh
    case logout
}

extension AuthEndpoint: Endpoint {
    public var queryItems: [URLQueryItem]? {
        nil
    }

    public var path: String {
        switch self {
        case .login:
            return "/api/v1/auth/login"
        case .refresh:
            return "/api/v1/auth/refresh"
        case .logout:
            return "/api/v1/auth/logout"
        }
    }

    public var port: Int {
        7076
    }

    public var method: RequestMethod {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }

    public var body: [String: String]? {
        nil
    }

    public var header: [String: String]? {
        switch self {
        case let .login(email, password):
            let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()

            let header = [
                "Authorization": "Basic \(authData)",
                "X-Device-Id": "134ACE7F-12B1-4CB0-8640-CCA1E277A42D--",
                "X-Platform": "OSX",
                "X-Device-Name": "iPhone 12 Mini"
            ]
            return header
        case .refresh:
            guard let refreshToken = KeychainHelper.shared.loadData(
                service: KeychainConstants.refreshTokenService,
                account: KeychainConstants.account
            ),
                let refreshTokenString = String(data: refreshToken, encoding: .utf8)
            else { return nil }
            return ["Authorization": "Refresh \(refreshTokenString)"]
        case .logout:
            return nil
        }
    }
}
