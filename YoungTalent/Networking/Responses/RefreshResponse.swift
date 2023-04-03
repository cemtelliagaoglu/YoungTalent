//
//  RefreshResponse.swift
//  YoungTalent
//
//  Created by admin on 3.04.2023.
//

import Foundation

public struct RefreshResponse: Codable {
    public let error: Bool
    public let reason: String
    public let body: RefreshBody?

    // MARK: - RefreshBody

    public struct RefreshBody: Codable {
        public let id: String
        public let nameSurname: String
        public let title: String
        public let profilePhoto: String?
        public let accessToken: String
        public let refreshToken: String
        public let email: String
        public let phoneNumber: String?
        public let pushNotificationToken: String?
        public let pushNotificationEnabled: Bool
    }
}
