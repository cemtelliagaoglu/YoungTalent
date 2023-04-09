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
        Task {
            do {
                let response = try await worker.getUserProfile()
                guard let profile = response.last else { return }
                profileData = profile
                presenter?.presentProfile(model: profile)
            } catch {
                guard let error = error as? CoreDataError else { return }
                presenter?.presentErrorMessage(error.customMessage)
            }
        }
    }

    func saveProfile(dateOfBirth: Date, gender: String) {
        if let currentProfileData = profileData {
            currentProfileData.dateOfBirth = dateOfBirth
            currentProfileData.gender = gender
            Task {
                do {
                    try await worker.updateProfile()
                    presenter?.presentProfile(model: currentProfileData)
                } catch {
                    guard let error = error as? CoreDataError else { return }
                    presenter?.presentErrorMessage(error.customMessage)
                }
            }
        } else {
            Task {
                do {
                    let profileData = try await worker.createUserProfile(
                        profile: .init(
                            dateOfBirth: dateOfBirth,
                            gender: gender
                        )
                    )
                    self.profileData = profileData
                    presenter?.presentProfile(model: profileData)
                } catch {
                    guard let error = error as? CoreDataError else { return }
                    presenter?.presentErrorMessage(error.customMessage)
                }
            }
        }
    }
}
