//
//  TextView Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import Foundation
import UIKit

extension UITextView {
    
    func with(fontName: String, size: CGFloat) -> Self {
        font = UIFont(name: fontName, size: size)
        return self
    }
    
    
    func with(keybordType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    
    func with(textContainerInset: UIEdgeInsets) -> Self{
        self.textContainerInset = textContainerInset
        return self
    }
}
