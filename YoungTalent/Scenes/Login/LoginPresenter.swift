//
//  LoginPresenter.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol LoginPresentationLogic: AnyObject {
    func displayData()
}

final class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
    
    func displayData() {
        viewController?.setupView()
    }
}
