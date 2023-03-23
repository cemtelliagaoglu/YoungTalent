//
//  WelcomePresenter.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol WelcomePresentationLogic: AnyObject {
    func presentConfigurations(isDarkMode: Bool?)
    func presentDarkMode(_ isDarkMode: Bool)
}

final class WelcomePresenter: WelcomePresentationLogic {
    weak var viewController: WelcomeDisplayLogic?

    func presentConfigurations(isDarkMode: Bool?) {
        viewController?.setupView(isDarkMode: isDarkMode ?? false)
    }

    func presentDarkMode(_ isDarkMode: Bool) {
        viewController?.updateView(isDarkMode: isDarkMode)
    }
}
