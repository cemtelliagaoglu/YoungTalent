//
//  UserEndpoint.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

public enum UserEndpoint {
    case currentUser
    case allUsers
}

extension UserEndpoint: Endpoint {
    public var queryItems: [URLQueryItem]? {
        nil
    }

    public var path: String {
        switch self {
        case .currentUser:
            return "/api/v1/auth/me"
        case .allUsers:
            return "/api/v1/auth"
        }
    }

    public var port: Int {
        7076
    }

    public var method: RequestMethod {
        switch self {
        case .currentUser:
            return .get
        default:
            return .get
        }
    }

    public var body: [String: String]? {
        nil
    }

    public var header: [String: String]? {
        guard let tokenData = KeychainHelper.shared.loadData(
            service: KeychainConstants.service,
            account: KeychainConstants.account
        ) else { return nil }
        guard let accessToken = String(data: tokenData, encoding: .utf8) else { return nil }
        return ["Authorization": "Bearer \(accessToken)"]
    }
}
