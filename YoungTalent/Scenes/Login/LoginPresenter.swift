//
//  LoginPresenter.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol LoginPresentationLogic: AnyObject {
    func presentLoginSucceed()
    func presentErrorMessage(_ errorMessage: String)
}

final class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
    
    func presentLoginSucceed() {
        viewController?.stopLoadingAnimation()
        viewController?.displayLogin()
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        viewController?.stopLoadingAnimation()
        viewController?.displayErrorMessage(errorMessage)
    }
}
