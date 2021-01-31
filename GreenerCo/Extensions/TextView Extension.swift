//
//  TextView Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import Foundation
import UIKit

extension UITextView {
    
    /// Self return UITextView with given Font Name and Size.
    /// - parameter fontName: Label font name
    /// - parameter size: Label font size
    func with(fontName: String, size: CGFloat) -> Self {
        font = UIFont(name: fontName, size: size)
        return self
    }
    
    
    /// Self return UITextView with given Keyboard Type.
    /// - parameter keybordType: Keyboard type.
    func with(keybordType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    
    /// Self return UITextView with given Text Container Inset.
    /// - parameter textContainerInset: Text container Inset.
    func with(textContainerInset: UIEdgeInsets) -> Self{
        self.textContainerInset = textContainerInset
        return self
    }
}
