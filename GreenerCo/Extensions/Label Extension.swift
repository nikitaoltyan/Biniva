//
//  Label Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 27.01.2021.
//

import Foundation
import UIKit

extension UILabel {

    /// Self return UILabel with given Font Name and Size.
    /// - parameter fontName: Label font name
    /// - parameter size: Label font size
    func with(fontName: String, size: CGFloat) -> Self {
        font = UIFont(name: fontName, size: size)
        return self
    }
    
    
    /// Self return UILabel with given Text Color.
    /// - parameter color: Label text color
    func with(color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    
    /// Self return UILabel with given Text Alignment.
    /// - parameter alignment: Text Alignment
    func with(alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    
    /// Self return UILabel with given Number of Lines.
    /// - parameter numberOfLines: Number of lines for UILabel. 0 if it doesn't matter.
    func with(numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
}
