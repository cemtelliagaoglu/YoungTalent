//
//  HomeWorker.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import Foundation

protocol HomeWorkingLogic: AnyObject {
    func fetchCurrentUser() async throws -> UserResponse
    func fetchGroups() async throws -> AllGroupsResponse
    func fetchAllUsers() async throws -> AllUsersResponse
    func deleteRefreshToken(completion: @escaping (() -> Void))
    func updateDarkMode(completion: @escaping ((Bool) -> Void))
}

final class HomeWorker: HomeWorkingLogic, HTTPClient {
    func fetchCurrentUser() async throws -> UserResponse {
        do {
            let response = try await sendRequest(
                endpoint: UserEndpoint.currentUser,
                responseModel: UserResponse.self
            )
            return response
        } catch {
            throw error
        }
    }

    func fetchGroups() async throws -> AllGroupsResponse {
        do {
            let response = try await sendRequest(
                endpoint: GroupsEndpoint.all,
                responseModel: AllGroupsResponse.self
            )
            return response
        } catch {
            throw error
        }
    }

    func fetchAllUsers() async throws -> AllUsersResponse {
        do {
            let response = try await sendRequest(
                endpoint: UserEndpoint.allUsers,
                responseModel: AllUsersResponse.self
            )
            return response
        } catch {
            throw error
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
