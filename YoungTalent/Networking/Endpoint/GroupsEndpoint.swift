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

    public var port: Int {
        7076
    }

    public var method: RequestMethod {
        switch self {
        case .all:
            return .get
        default:
            return .get
        }
    }

    public var body: [String: String]? {
        nil
    }

    public var header: [String: String]? {
        // TODO: Access Token to use in Bearer header, could be get and set via Singleton Keychain Manager
        guard let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String else { return nil }

        switch self {
        case .all:
            return [
                "Authorization": "Bearer \(accessToken)",
            ]
        default:
            return nil
        }
    }
}
