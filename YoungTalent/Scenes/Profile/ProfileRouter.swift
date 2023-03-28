//
//  ProfileRouter.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import Foundation

protocol ProfileRoutingLogic: AnyObject {
    func popViewController()
    func showAlert(title: String, message: String)
}

protocol ProfileDataPassing: AnyObject {
    var dataStore: ProfileDataStore? { get }
}

final class ProfileRouter: ProfileRoutingLogic, ProfileDataPassing {
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?

    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func showAlert(title: String, message: String) {
        viewController?.presentAlert(title: title, message: message)
    }
}
