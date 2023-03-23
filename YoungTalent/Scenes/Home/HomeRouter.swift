//
//  HomeRouter.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import UIKit

protocol HomeRoutingLogic: AnyObject {
    func routeToChat(index: Int)
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
}
