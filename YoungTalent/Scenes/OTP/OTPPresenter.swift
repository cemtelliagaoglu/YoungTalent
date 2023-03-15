//
//  OTPPresenter.swift
//  YoungTalent
//
//  Created by admin on 15.03.2023.
//

import Foundation

protocol OTPPresentationLogic: AnyObject {
    func presentSuccess()
    func presentErrorMessage(_ errorMessage: String)
}

final class OTPPresenter: OTPPresentationLogic {
    
    weak var viewController: OTPDisplayLogic?
    
    func presentSuccess() {
        viewController?.displaySuccess()
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage)
    }
}
