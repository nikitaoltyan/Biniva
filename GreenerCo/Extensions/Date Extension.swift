//
//  Date Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 31.01.2021.
//

import Foundation

extension Date {
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "DD"
        return dateFormatter.string(from: self)
    }
}
