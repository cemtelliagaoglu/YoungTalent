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
}

protocol WelcomeDataPassing: AnyObject {
    var dataStore: WelcomeDataStore? { get }
}

final class WelcomeRouter: WelcomeRoutingLogic, WelcomeDataPassing {
    
    weak var viewController: WelcomeVC?
    var dataStore: WelcomeDataStore?
    
    func routeToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func routeToRegister() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC")
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
