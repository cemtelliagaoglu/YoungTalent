//
//  LoginInteractor.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol LoginBusinessLogic: AnyObject {
    func notifyViewDidLoad()
}

protocol LoginDataStore: AnyObject {
    
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    
    func notifyViewDidLoad() {
        presenter?.displayData()
    }
}
