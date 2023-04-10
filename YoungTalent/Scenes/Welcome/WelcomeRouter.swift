//
//  WelcomeRouter.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import UIKit

protocol WelcomeRoutingLogic: AnyObject {
    func routeToLogin()
    func routeToRegister()
    func routeToHome()
}

protocol WelcomeDataPassing: AnyObject {
    var dataStore: WelcomeDataStore? { get }
}

final class WelcomeRouter: WelcomeRoutingLogic, WelcomeDataPassing {
    weak var viewController: WelcomeVC?
    var dataStore: WelcomeDataStore?

    func routeToLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    func routeToRegister() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC")
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    func routeToHome() {
        guard let currentUser = dataStore?.currentUserData else { return }
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        DispatchQueue.main.async { [weak self] in
            guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
            else { return }
            destinationVC.currentUserViewModel = .init(
                nameSurname: currentUser.nameSurname,
                profilePhoto: currentUser.profilePhoto,
                title: currentUser.title
            )
            self?.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
