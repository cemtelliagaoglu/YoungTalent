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
        
        self.worker.requestLogin(email: email, password: password) { result in
            switch result{
            case .success(let response):
                if response.error == true{
                    self.presenter?.presentErrorMessage(response.reason)
                }else{
                    UserDefaults.standard.set(response.body?.accessToken, forKey: "accessToken")
                    self.currentUser = response.body
                    self.presenter?.presentLoginSucceed()
                }
            case .failure(let error):
                self.presenter?.presentErrorMessage(error.customMessage)
            }
        }
    }
}
