//
//  WelcomeWorker.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol WelcomeWorkingLogic: AnyObject {
    func fetchData(completion: @escaping ((Bool?) -> Void))
    func checkLoginStatus() async throws -> RefreshResponse
    func updateDarkMode(_ newValue: Bool, completion: () -> Void)
}

final class WelcomeWorker: WelcomeWorkingLogic, HTTPClient {
    func fetchData(completion: @escaping ((Bool?) -> Void)) {
        let isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool
        completion(isDarkMode)
    }

    func checkLoginStatus() async throws -> RefreshResponse {
        do {
            let response = try await sendRequest(
                endpoint: AuthEndpoint.refresh,
                responseModel: RefreshResponse.self
            )
            return response
        } catch {
            throw error
        }
    }

    func updateDarkMode(_ newValue: Bool, completion: () -> Void) {
        // save the change to UserDefaults
        UserDefaults.standard.set(newValue, forKey: "isDarkMode")
        completion()
    }
}
