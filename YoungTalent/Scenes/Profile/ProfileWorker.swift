//
//  ProfileWorker.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import Foundation

protocol ProfileWorkingLogic: AnyObject {
    func getUserProfile(
        completion: @escaping ((Result<Profile.Case.Response, Error>) -> Void)
    )
    func saveProfile(completion: @escaping ((Error?) -> Void))
}

final class ProfileWorker: ProfileWorkingLogic {
    func getUserProfile(completion: @escaping ((Result<Profile.Case.Response, Error>) -> Void)) {}

    func saveProfile(completion: @escaping ((Error?) -> Void)) {
//        completion()
    }
}
