//
//  File.swift
//  GreenerCo
//
//  Created by Никита Олтян on 26.01.2021.
//

import Foundation


extension Dictionary {
    
    /// Self return Dictionary, merged with given Dictionary.
    /// - parameter dict: Dictionary to merge with main Dictionary
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
