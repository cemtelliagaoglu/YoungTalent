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

            URLSession.shared.dataTask(with: request, completionHandler: ({ data, _, error in

                if error != nil {
                    print(error!)
                }
                if let imageData = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imageData) ?? UIImage(named: "personalEmpty")
                    }
                }
            })).resume()
        } else {
            // if urlPath is nil
            DispatchQueue.main.async {
                self.image = UIImage(named: "personalEmpty")
            }
        }
    }
}
