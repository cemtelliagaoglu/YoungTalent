//
//  ProfilePresenter.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import Foundation

protocol ProfilePresentationLogic: AnyObject {
    func presentProfile(model: UserProfile)
    func presentErrorMessage(_ errorMessage: String)
}

final class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?

    func presentProfile(model: UserProfile) {
        viewController?.displayUserProfile(
            viewModel: .init(
                dateOfBirth: model.dateOfBirth ?? .now,
                gender: model.gender ?? "Male"
            )
        )
    }

    func presentErrorMessage(_ errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage)
    }
}
