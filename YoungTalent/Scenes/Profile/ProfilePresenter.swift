//
//  ProfilePresenter.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import Foundation

protocol ProfilePresentationLogic: AnyObject {
    func presentProfile(model: Profile.Case.Response)
    func presentErrorMessage(_ errorMessage: String)
}

final class ProfilePresenter: ProfilePresentationLogic {
    weak var viewController: ProfileDisplayLogic?

    func presentProfile(model: Profile.Case.Response) {
        viewController?.displayUserProfile(
            viewModel: .init(
                dateOfBirth: model.dateOfBirth,
                gender: model.gender
            )
        )
    }

    func presentErrorMessage(_ errorMessage: String) {}
}
