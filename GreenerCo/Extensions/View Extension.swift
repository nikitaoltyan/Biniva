//
//  View Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 26.01.2021.
//

import Foundation
import UIKit

extension UIView {

    /// Self return UIView with given border width and color.
    /// - parameter borderWidth: View border width
    /// - parameter color: View border color (CGColor)
    func with(borderWidth: CGFloat, color: CGColor) -> Self {
        layer.borderWidth = borderWidth
        layer.borderColor = color
        return self
    }
    
    
    /// Return Self UIView with given background color.
    /// - parameter bgColor: View background color
    func with(bgColor: UIColor) -> Self {
        backgroundColor = bgColor
        return self
    }
    
    
    /// Self return UIView with given corner radius.
    /// - parameter cornerRadius: View corner radius
    func with(cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius = cornerRadius
        return self
    }
}
