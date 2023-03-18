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
}

protocol ChatDataPassing: AnyObject {
    var dataStore: ChatDataStore? { get }
}

final class ChatRouter: ChatRoutingLogic, ChatDataPassing {
    
    weak var viewController: ChatViewController?
    var dataStore: ChatDataStore?
    
    func routeToPHPicker(){
        var config = PHPickerConfiguration()
        config.selectionLimit = 20
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = viewController
        viewController?.present(pickerViewController, animated: true)
    }
    
    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
