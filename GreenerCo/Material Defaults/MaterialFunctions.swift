//
//  MaterialFunctions.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 17.05.2021.
//

import UIKit

class MaterialFunctions {
    
    func calculate() -> Array<(Int, Double)> {
        let data = DataFunction().fetchData()
        guard (data.count != 0) else { return [] }
        
        var result: Array<(Int, Double)> = []
        var dict: [Int:Int] = [:]
        var sum: Int = 0
        
        for row in 0...data.count-1 {
            let material = data[row].logMaterial
            let size = data[row].logSize
            let materialCount = material?.count ?? 1
            for item in 0...materialCount-1 {
                let id = material?[item] ?? 0
                let check = dict[id]
                if (check != nil) {
                    dict[id]! += size?[item] ?? 0
                } else {
                    dict[id] = size?[item] ?? 0
                }
                sum += size?[item] ?? 0
            }
        }
        // Here we have dict with [MaterialID: ItsSize] and sum of all sizes.
        
        while dict.count>0 {
            let m = dict.max { a, b in a.value < b.value }
            guard let max = m else { return []}
            dict.removeValue(forKey: max.key)
            result.append((max.key, Double(max.value)/Double(sum)))
        }
        return result
    }
    
    func statsHeightFunction(maxProportion max: Double) -> (Double) -> (CGFloat)  {
        guard (max != 0) else { return resultFunction(a: 0, b: 0) }
        let y: CGFloat = 85
        let a = y/CGFloat(max)
        let b = y-a*CGFloat(max)
        return resultFunction(a: a, b: b)
    }
    
    fileprivate
    func resultFunction(a: CGFloat, b: CGFloat)  -> (Double) -> (CGFloat) {
        return { x in (a*CGFloat(x) + b)}
    }
}
