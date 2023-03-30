//
//  ProfileInteractor.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import Foundation

protocol ProfileBusinessLogic: AnyObject {
    func loadUserProfile()
    func saveProfile(dateOfBirth: Date, gender: String)
}

protocol ProfileDataStore: AnyObject {
    var profileData: UserProfile? { get set }
}

final class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorkingLogic = ProfileWorker()
    var profileData: UserProfile?

    func loadUserProfile() {
        worker.getUserProfile { [weak self] result in
            switch result {
            case let .success(response):
                guard let profile = response.last else { return }
                self?.profileData = profile
                self?.presenter?.presentProfile(model: profile)
            case let .failure(error):
                self?.presenter?.presentErrorMessage(error.localizedDescription)
            }
        }
    }

    func saveProfile(dateOfBirth: Date, gender: String) {
        if let currentProfileData = profileData {
            currentProfileData.dateOfBirth = dateOfBirth
            currentProfileData.gender = gender
            worker.updateProfile { [weak self] result in
                switch result {
                case .success:
                    self?.presenter?.presentProfile(model: currentProfileData)
                case let .failure(error):
                    self?.presenter?.presentErrorMessage(error.customMessage)
                }
            }
        } else {
            worker.createUserProfile(
                profile: .init(
                    dateOfBirth: dateOfBirth,
                    gender: gender
                )
            ) { [weak self] result in
                switch result {
                case let .success(profileData):
                    self?.profileData = profileData
                    self?.presenter?.presentProfile(model: profileData)
                case let .failure(error):
                    self?.presenter?.presentErrorMessage(error.customMessage)
                }
            }
        }
    }
}
