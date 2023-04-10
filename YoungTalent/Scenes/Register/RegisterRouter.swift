//
//  RegisterRouter.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import UIKit

protocol RegisterRoutingLogic: AnyObject {
    func popVC()
    func routeToHome()
}

protocol RegisterDataPassing: AnyObject {
    var dataStore: RegisterDataStore? { get }
}

final class RegisterRouter: RegisterRoutingLogic, RegisterDataPassing {
    weak var viewController: RegisterVC?
    var dataStore: RegisterDataStore?

    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func routeToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
