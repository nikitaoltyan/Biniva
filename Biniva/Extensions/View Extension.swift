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
    
    
    /// Self return UILabel with given autolayout.
    /// - parameter autolayout: Shoud the label Translates Autoresizing Mask Into Constraints.
    func with(autolayout: Bool) -> Self {
        translatesAutoresizingMaskIntoConstraints = autolayout
        return self
    }
    
    
    func withDashedBorder(lineWidth width: CGFloat, withColor color: UIColor, lineDashesPattern pattern: [NSNumber], Y: CGFloat) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = pattern
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: Int(Y)),
                                CGPoint(x: 215, y: Int(Y))])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
