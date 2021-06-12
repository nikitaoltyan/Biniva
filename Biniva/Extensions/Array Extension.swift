//
//  Array Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 17.02.2021.
//

import Foundation
import UIKit


extension Array where Element == String {
    mutating func randomElements(numberOfElements number: Int) -> Array<String> {
        guard (number>0) else { return [] }
        var returnArr: Array<String> = []
        for _ in 1...number{
            guard let element = self.randomElement() else { return ["1"] }
            returnArr.append(element)
            if let index = self.firstIndex(of: element) {
                self.remove(at: Int(index))
            }
        }
        return returnArr
    }
}



extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}

extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
    /// Returns the average of all elements in the array as Floating Point type
    func average<T: FloatingPoint>() -> T { isEmpty ? .zero : T(sum()) / T(count) }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : Element(sum()) / Element(count) }
}
