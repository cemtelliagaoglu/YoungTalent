//
//  UIView+Extension.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get{
            layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderWidth: CGFloat{
        get{
            layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
}
