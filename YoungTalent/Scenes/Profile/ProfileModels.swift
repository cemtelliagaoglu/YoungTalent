//
//  ProfileModels.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import Foundation

// swiftlint:disable nesting
enum Profile {
    enum Case {
        struct Request {}

        struct Response {
            let dateOfBirth: Date
            let gender: String
        }

        struct ViewModel {
            let dateOfBirth: Date
            let gender: String
        }
    }
}

// swiftlint:enable nesting
