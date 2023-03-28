//
//  HomeRouter.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import UIKit

protocol HomeRoutingLogic: AnyObject {
    func routeToChat(index: Int)
    func routeToProfile()
}

protocol HomeDataPassing: AnyObject {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeVC?
    var dataStore: HomeDataStore?

    func routeToChat(index: Int) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        guard let destinationVC = storyboard.instantiateViewController(
            withIdentifier: "ChatViewController"
        ) as? ChatViewController else { return }
        destinationVC.router?.dataStore?.contact = dataStore?.contacts?[index]
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    func routeToProfile() {
        DispatchQueue.main.async { [weak self] in
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(
                withIdentifier: "ProfileViewController"
            )
            self?.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
