//
//  CommonButton.swift
//
//
//  Created by admin on 5.04.2023.
//

import UIKit

public class CommonButton: UIButton {
    public func setButton(
        image: UIImage? = nil,
        backgroundColor: UIColor? = .clear
    ) {
        setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
    }
}
