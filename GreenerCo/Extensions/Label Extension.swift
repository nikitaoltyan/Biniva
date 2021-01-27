//
//  Label Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import Foundation
import UIKit

extension UILabel {

    
    func with(fontName: String, size: CGFloat) -> Self {
        font = UIFont(name: fontName, size: size)
        return self
    }
    
    
    func with(color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    
    func with(alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    
    func with(numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
}
