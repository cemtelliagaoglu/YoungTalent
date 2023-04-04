//
//  ChatModels.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import Foundation

// swiftlint:disable nesting
enum Chat {
    enum Case {
        struct Request {}

        struct Response {
            let user: User
        }

        enum ViewModel {
            struct User {
                let nameSurname: String
                let profilePhoto: String?
                let title: String

                var fullName: String? {
                    "\(nameSurname) (\(title))"
                }
            }
        }

        struct Location {
            let longitude: Double
            let latitude: Double
        }
    }
}

// swiftlint:enable nesting
