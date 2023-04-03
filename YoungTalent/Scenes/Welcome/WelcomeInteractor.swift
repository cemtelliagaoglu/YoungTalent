//
//  WelcomeInteractor.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol WelcomeBusinessLogic: AnyObject {
    func fetchConfigurations()
    func switchDarkMode(newValue: Bool)
}

protocol WelcomeDataStore: AnyObject {
    var currentUserData: RefreshResponse.RefreshBody? { get set }
}

final class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore {
    var presenter: WelcomePresentationLogic?
    var worker: WelcomeWorkingLogic = WelcomeWorker()
    var currentUserData: RefreshResponse.RefreshBody?

    func fetchConfigurations() {
        worker.checkLoginStatus { [weak self] result in
            switch result {
            case let .success(response):
                guard let accessTokenString = response.body?.accessToken,
                      let refreshTokenString = response.body?.refreshToken
                else { return }

                KeychainHelper.shared.saveData(
                    Data(accessTokenString.utf8),
                    service: KeychainConstants.accessTokenService,
                    account: KeychainConstants.account
                )

                KeychainHelper.shared.saveData(
                    Data(refreshTokenString.utf8),
                    service: KeychainConstants.refreshTokenService,
                    account: KeychainConstants.account
                )
                self?.currentUserData = response.body
                self?.presenter?.presentUserLoggedIn()
            case let .failure(error):
                print(error.customMessage)
            }
        }
        worker.fetchData { isDarkMode in
            self.presenter?.presentConfigurations(isDarkMode: isDarkMode)
        }
    }

    func switchDarkMode(newValue: Bool) {
        worker.updateDarkMode(newValue) {
            presenter?.presentDarkMode(newValue)
        }
    }
}
