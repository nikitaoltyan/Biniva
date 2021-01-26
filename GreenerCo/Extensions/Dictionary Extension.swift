//
//  File.swift
//  GreenerCo
//
//  Created by Никита Олтян on 26.01.2021.
//

import Foundation


extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
