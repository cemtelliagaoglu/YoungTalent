//
//  UIViewController+Extension.swift
//  YoungTalent
//
//  Created by admin on 24.03.2023.
//

import UIKit

extension UIViewController {
    func presentAlert(
        title: String,
        message: String
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
