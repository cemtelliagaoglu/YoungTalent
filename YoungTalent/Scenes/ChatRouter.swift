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
    func showMediaAlert()
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

    private func routeToPHPicker(filter: PHPickerFilter) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 20
        config.filter = filter
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

    func showMediaAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Send Photo", style: .default) { [weak self] _ in
            self?.routeToPHPicker(filter: .images)
        })

        alert.addAction(UIAlertAction(title: "Watch Video", style: .default) { [weak self] _ in
            self?.routeToVideo()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewController?.present(alert, animated: true)
    }

    private func routeToVideo() {
        DispatchQueue.main.async { [weak self] in
            let destination = MediaDetailsViewController()
            destination.viewingMode = .video
            self?.viewController?.navigationController?.pushViewController(destination, animated: true)
        }
    }

    func showAlert(title: String, message: String) {
        viewController?.presentAlert(title: title, message: message)
    }
}
