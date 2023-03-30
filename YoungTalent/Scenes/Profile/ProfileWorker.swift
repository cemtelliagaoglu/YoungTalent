//
//  ProfileWorker.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import Foundation

protocol ProfileWorkingLogic: AnyObject {
    func getUserProfile(
        completion: @escaping ((Result<[UserProfile], CoreDataError>) -> Void)
    )
    func updateProfile(completion: @escaping ((Result<Void, CoreDataError>) -> Void))
    func createUserProfile(
        profile: Profile.Case.Request,
        completion: @escaping ((Result<UserProfile, CoreDataError>) -> Void)
    )
}

final class ProfileWorker: ProfileWorkingLogic {
    private let coreDataManager = CoreDataManager.shared

    func getUserProfile(completion: @escaping ((Result<[UserProfile], CoreDataError>) -> Void)) {
        CoreDataManager.shared.read(type: UserProfile.self) { result in
            completion(result)
        }
    }

    func updateProfile(completion: @escaping ((Result<Void, CoreDataError>) -> Void)) {
        coreDataManager.update(completion: completion)
    }

    func createUserProfile(
        profile: Profile.Case.Request,
        completion: @escaping ((Result<UserProfile, CoreDataError>) -> Void)
    ) {
        coreDataManager.create(type: UserProfile.self) { [weak self] result in
            switch result {
            case let .success(profileResponse):
                profileResponse.dateOfBirth = profile.dateOfBirth
                profileResponse.gender = profile.gender
                self?.coreDataManager.update(completion: { result in
                    switch result {
                    case .success:
                        completion(.success(profileResponse))
                    case let .failure(saveError):
                        completion(.failure(saveError))
                    }
                })
            case let .failure(createError):
                completion(.failure(createError))
            }
        }
    }
}
