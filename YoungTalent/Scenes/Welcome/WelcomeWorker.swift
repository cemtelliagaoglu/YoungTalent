//
//  WelcomeWorker.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol WelcomeWorkingLogic: AnyObject {
    func fetchData(completion: @escaping ((Bool?) -> Void))
    func checkLoginStatus(completion: @escaping ((Result<RefreshResponse, RequestError>) -> Void))
    func updateDarkMode(_ newValue: Bool, completion: () -> Void)
}

final class WelcomeWorker: WelcomeWorkingLogic, HTTPClient {
    func fetchData(completion: @escaping ((Bool?) -> Void)) {
        let isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool
        completion(isDarkMode)
    }

    func checkLoginStatus(completion: @escaping ((Result<RefreshResponse, RequestError>) -> Void)) {
        sendRequest(
            endpoint: AuthEndpoint.refresh,
            responseModel: RefreshResponse.self,
            completion: completion
        )
    }

    func updateDarkMode(_ newValue: Bool, completion: () -> Void) {
        // save the change to UserDefaults
        UserDefaults.standard.set(newValue, forKey: "isDarkMode")
        completion()
    }
}
