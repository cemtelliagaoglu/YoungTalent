//
//  RegisterInteractor.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol RegisterBusinessLogic: AnyObject {
    func notifyViewDidLoad()
}

protocol RegisterDataStore: AnyObject {}

final class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorkingLogic = RegisterWorker()

    func notifyViewDidLoad() {
        presenter?.presentConfigurations()
    }
}
