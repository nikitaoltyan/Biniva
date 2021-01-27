//
//  View Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 26.01.2021.
//

import Foundation
import UIKit

extension UIView {

    func with(borderWidth: CGFloat, color: CGColor) -> Self {
        layer.borderWidth = borderWidth
        layer.borderColor = color
        return self
    }
    
    func with(bgColor: UIColor) -> Self {
        backgroundColor = bgColor
        return self
    }
}
