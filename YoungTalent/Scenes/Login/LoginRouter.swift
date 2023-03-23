//
//  LoginRouter.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import UIKit

protocol LoginRoutingLogic: AnyObject {
    func routeToHome()
    func popVC()
}

protocol LoginDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginVC?
    var dataStore: LoginDataStore?

    func routeToHome() {
        guard let currentUser = dataStore?.currentUser else { return }

        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        DispatchQueue.main.async {
            guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
            else { return }

            destinationVC.currentUserViewModel = .init(
                nameSurname: currentUser.nameSurname,
                profilePhoto: currentUser.profilePhoto,
                title: currentUser.title
            )

            self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }

    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
