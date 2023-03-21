//
//  LoginWorker.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol LoginWorkingLogic: AnyObject {
    func requestLogin(email: String, password: String, completion: @escaping((Result<LoginResponse, RequestError>) -> ()))
}

final class LoginWorker: LoginWorkingLogic, HTTPClient {

    func requestLogin(email: String, password: String, completion: @escaping((Result<LoginResponse, RequestError>) -> ())) {
        sendLoginRequest(withEmail: email, password: password) { result in
            completion(result)
        }
    }
}
