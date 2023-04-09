//
//  UIImageView+Extension.swift
//  YoungTalent
//
//  Created by admin on 13.03.2023.
//

import UIKit

extension UIImageView {
    func downloadImage(with urlPath: String?) {
        if let urlPath {
            let request = URLRequest(url: URL(string: "http://\(urlPath)")!)
            Task {
                do {
                    let (imageData, _) = try await URLSession.shared.data(for: request)
                    self.image = UIImage(data: imageData) ?? UIImage(named: "personalEmpty")
                } catch {
                    print(error)
                }
            }
        } else {
            // if urlPath is nil
            Task {
                self.image = UIImage(named: "personalEmpty")
            }
        }
    }
}
