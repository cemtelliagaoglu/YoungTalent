//
//  LoginInteractor.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol LoginBusinessLogic: AnyObject {
    func requestLoginWith(_ email: String, _ password: String)
}

protocol LoginDataStore: AnyObject {
    var currentUser: LoginResponse.LoginBody? { get set }
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    var currentUser: LoginResponse.LoginBody?

    func requestLoginWith(_ email: String, _ password: String) {
        worker.requestLogin(email: email, password: password) { result in
            switch result {
            case let .success(response):
                if response.error == true {
                    self.presenter?.presentErrorMessage(response.reason)
                } else {
                    guard let accessTokenString = response.body?.accessToken,
                          let refreshTokenString = response.body?.refreshToken
                    else {
                        self.presenter?.presentErrorMessage("Failed to fetch access token")
                        return
                    }

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
                    self.currentUser = response.body
                    self.presenter?.presentLoginSucceed()
                }
            case let .failure(error):
                self.presenter?.presentErrorMessage(error.customMessage)
            }
        }
    }
}
