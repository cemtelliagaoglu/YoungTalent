//
//  ProfileInteractor.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import Foundation

protocol ProfileBusinessLogic: AnyObject {
    func loadUserProfile()
    func saveDate(_ date: Date)
    func saveGender(_ gender: String)
    func saveProfile(dateOfBirth: Date, gender: String)
}

protocol ProfileDataStore: AnyObject {}

final class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorkingLogic = ProfileWorker()

    func loadUserProfile() {}

    func saveDate(_ date: Date) {
        print(date)
    }

    func saveGender(_ gender: String) {
        print(gender)
    }

    func saveProfile(dateOfBirth: Date, gender: String) {}
}
