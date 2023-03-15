//
//  LoginRouter.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import UIKit

protocol LoginRoutingLogic: AnyObject {
    func routeToOTP()
    func popVC()
}

protocol LoginDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginVC?
    var dataStore: LoginDataStore?
    
    func routeToOTP() {
        let storyboard = UIStoryboard(name: "OTP", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "OTPVC")
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
