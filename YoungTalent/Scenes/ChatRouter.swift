//
//  ChatRouter.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import Foundation
import PhotosUI

protocol ChatRoutingLogic: AnyObject {
    func popVC()
    func routeToPHPicker()
    func routeToMediaDetails(images: [UIImage]?)
    func routeToMapView()
    func showAlert(title: String, message: String)
}

protocol ChatDataPassing: AnyObject {
    var dataStore: ChatDataStore? { get }
}

final class ChatRouter: ChatRoutingLogic, ChatDataPassing {
    weak var viewController: ChatViewController?
    var dataStore: ChatDataStore?

    func routeToPHPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 20
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = viewController
        viewController?.present(pickerViewController, animated: true)
    }

    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func routeToMediaDetails(images: [UIImage]?) {
        DispatchQueue.main.async { [weak self] in
            let destination = MediaPageViewController()
            destination.images = images
            self?.viewController?.navigationController?.pushViewController(destination, animated: true)
        }
    }

    func routeToMapView() {
        guard let location = dataStore?.location else { return }
        DispatchQueue.main.async { [weak self] in
            let destination = MapViewController()
            destination.viewModel = location
            self?.viewController?.navigationController?.pushViewController(destination, animated: true)
        }
    }

    func showAlert(title: String, message: String) {
        viewController?.presentAlert(title: title, message: message)
    }
}
