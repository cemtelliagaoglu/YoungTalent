//
//  RegisterPresenter.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol RegisterPresentationLogic: AnyObject {
    func presentConfigurations()
}

final class RegisterPresenter: RegisterPresentationLogic {
    
    weak var viewController: RegisterDisplayLogic?
    
    func presentConfigurations() {
        viewController?.setupView()
    }
}
