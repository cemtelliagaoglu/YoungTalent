//
//  ProfileWorker.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import Foundation

protocol ProfileWorkingLogic: AnyObject {
    func getUserProfile() async throws -> [UserProfile]
    func updateProfile() async throws
    func createUserProfile(profile: Profile.Case.Request) async throws -> UserProfile
}

final class ProfileWorker: ProfileWorkingLogic {
    private let coreDataManager = CoreDataManager.shared

    func getUserProfile() async throws -> [UserProfile] {
        do {
            let profile = try await coreDataManager.read(type: UserProfile.self)
            return profile
        } catch {
            throw error
        }
    }

    func updateProfile() async throws {
        Task {
            do {
                try await coreDataManager.update()
                return
            } catch {
                throw error
            }
        }
    }

    func createUserProfile(profile: Profile.Case.Request) async throws -> UserProfile {
        do {
            let profileResponse = try await coreDataManager.create(type: UserProfile.self)
            profileResponse.dateOfBirth = profile.dateOfBirth
            profileResponse.gender = profile.gender
            try await coreDataManager.update()
            return profileResponse
        } catch {
            throw error
        }
    }
}
