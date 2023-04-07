//
//  HomeWorker.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func fetchCurrentUser(completion: @escaping ((Result<UserResponse, RequestError>) -> Void))
    func fetchGroups(completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> Void))
    func fetchAllUsers(completion: @escaping ((Result<AllUsersResponse, RequestError>) -> Void))
    func deleteRefreshToken(completion: @escaping (() -> Void))
    func updateDarkMode(completion: @escaping ((Bool) -> Void))
}

final class HomeWorker: HomeWorkingLogic, HTTPClient {
    func fetchCurrentUser(completion: @escaping ((Result<UserResponse, RequestError>) -> Void)) {
        sendRequest(endpoint: UserEndpoint.currentUser, responseModel: UserResponse.self) { result in
            completion(result)
        }
    }

    func fetchGroups(completion: @escaping ((Result<AllGroupsResponse, RequestError>) -> Void)) {
        sendRequest(endpoint: GroupsEndpoint.all, responseModel: AllGroupsResponse.self) { result in
            completion(result)
        }
    }

    func fetchAllUsers(completion: @escaping ((Result<AllUsersResponse, RequestError>) -> Void)) {
        sendRequest(endpoint: UserEndpoint.allUsers, responseModel: AllUsersResponse.self) { result in
            completion(result)
        }
    }

    func deleteRefreshToken(completion: @escaping (() -> Void)) {
        KeychainHelper.shared.deleteData(
            service: KeychainConstants.refreshTokenService,
            account: KeychainConstants.account
        )
        completion()
    }

    func updateDarkMode(completion: @escaping ((Bool) -> Void)) {
        if let isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool {
            UserDefaults.standard.setValue(!isDarkMode, forKey: "isDarkMode")
            completion(!isDarkMode)
        } else {
            UserDefaults.standard.setValue(true, forKey: "isDarkMode")
            completion(true)
        }
    }
}
