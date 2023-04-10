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
        struct Request {
            let dateOfBirth: Date
            let gender: String
        }

        struct Response {}

        struct ViewModel: Equatable {
            var dateOfBirth: Date
            var gender: String
        }
    }
}

// swiftlint:enable nesting
