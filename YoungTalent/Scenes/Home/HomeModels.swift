//
//  HomeModels.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import Foundation

// swiftlint:disable nesting
enum Home {
    enum Case {
        struct Request {}

        struct Response {}

        enum ViewModel {
            struct GroupModel {
                let name: String
                let groupPhoto: String?
                let users: [User]?
                let lastMessage: GroupLastMessage?
            }

            struct GroupLastMessage {
                let fromUsername: String
                let message: String
            }

            struct User {
                public let nameSurname: String
                public let profilePhoto: String?
                public let title: String

                public var fullName: String? {
                    "\(nameSurname) (\(title))"
                }
            }
        }
    }
}

// swiftlint:enable nesting
