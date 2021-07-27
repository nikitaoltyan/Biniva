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
    
    
    func tap(completion: @escaping(_ completion: Bool) -> Void) {
        UIView.animate(withDuration: 0.06, animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.92, y: 0.92)
            self.alpha = 0.86
        }, completion: { (_) in
            UIView.animate(withDuration: 0.06, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                self.alpha = 1
            }, completion: { (_) in
                completion(true)
            })
        })
    }
    
    enum rotationAngle {
        case vertical
        case horizontal
    }
    
    func rotate(forPosition position: rotationAngle) {
        switch position {
        case .horizontal:
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(rotationAngle: 0)
            })
        case .vertical:
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            })
        }
    }
}
