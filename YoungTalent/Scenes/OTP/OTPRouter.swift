//
//  OTPRouter.swift
//  YoungTalent
//
//  Created by admin on 15.03.2023.
//

import UIKit

protocol OTPRoutingLogic: AnyObject {
    func routeToHome()
    func popVC()
}

protocol OTPDataPassing: AnyObject {
    var dataStore: OTPDataStore? { get }
}

final class OTPRouter: OTPRoutingLogic, OTPDataPassing {
    weak var viewController: OTPVC?
    var dataStore: OTPDataStore?

    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func routeToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
