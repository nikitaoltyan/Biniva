//
//  Parser.swift
//  Biniva
//
//  Created by Никита Олтян on 12.07.2021.
//

import UIKit

class Parser {
    
    
    /// Divides string into array of strings, divided by <tab> prefix.
    func tabParser(text: String) -> [String] {
        return text.components(separatedBy: "<tab>")
    }

}
