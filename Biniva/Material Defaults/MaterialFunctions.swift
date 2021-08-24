//
//  MaterialFunctions.swift
//  GreenerCo
//
//  Created by Nikita Oltyan on 17.05.2021.
//

import UIKit

class MaterialFunctions {
    
    let database = DataFunction()
    
    
    /// Calculate percentage for each material across all added data.
    func calculate() -> Array<(Int, Double)> {
        let data: [Model] = database.fetchData()
        guard (data.count != 0) else { return [] }
        
        var result: Array<(Int, Double)> = []
        var (dict, sum): ([Int: Int], Double) = prepareModelDict(data: data)
        // Here we have dict with [MaterialID: ItsWeight] and sum of all sizes.
        
        while dict.count > 0 {
            let m = dict.max { a, b in a.value < b.value }
            guard let max = m else { return [] }
            dict.removeValue(forKey: max.key)
            result.append((max.key, Double(max.value)/sum))
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
    
    
    /// Calculation of weekly report
    func calculateWeekly() -> Array<(Int, Double, direction)> {
        
        // TODO:
        // Add guard
//        guard Defaults.getDateLastWeeklyReportGenerated() != Date.today().previous(.sunday) else {
//            return
//        }
        
        let firstEnd = Date.today().previous(.sunday)
        let firstStart = firstEnd.previous(.sunday).previous(.saturday)
        
        let data: [Model] = database.fetchWeeklyData(start: firstStart, end: firstEnd)
        guard (data.count != 0) else { return [] }
        let (dict, _): ([Int: Int], Double) = prepareModelDict(data: data)
        // Here we have dict with [MaterialID: ItsWeight] for last week.
        
        
        
        let secondStart = firstStart.previous(.saturday)
        let secondEnd = firstStart.next(.sunday)
        
        let data2: [Model] = database.fetchWeeklyData(start: secondStart, end: secondEnd)
        guard (data2.count != 0) else { return [] }
        let (dict2, _): ([Int: Int], Double) = prepareModelDict(data: data2)
        // Here we have dict2 with [MaterialID: ItsWeight] for week before last.
        
        var result: Array<(Int, Double, direction)> = []
        
        // Step 1 Preparation
        // Need to preapre sets before actions with dict
        let dict1Keys: Set<Int> = Set(dict.keys)
        let dict2Keys: Set<Int> = Set(dict2.keys)
        
        var newDict: [Int: Double] = [:]
        // Step WTF
        for key in dict.keys {
            let keyExists = (dict2[key] != nil) // Checking if key exist in dict2
            
            if keyExists {
                let difference: Double = Double(dict[key] ?? 1) / Double(dict2[key] ?? 1)
                newDict[key] = difference-1.0
            }
            else {
                newDict[key] = 1.0
            }
        }
        
        
        // Step 2
        while newDict.count > 0 {
            let m = newDict.max { a, b in a.value < b.value }
            guard let max = m else { return [] }
            
            if max.value > 0 {
                result.append((max.key, max.value, .up))
            } else {
                result.append((max.key, max.value, .down))
            }
            newDict.removeValue(forKey: max.key)
        }
        
        
        // Step 3
        // Adding -1.0 for all keys that wasn't in first dict 
        for key in dict2Keys.subtracting(dict1Keys) {
            result.append((key, -1.0, .down))
        }
        return result
    }
    
    func weeklyHeightFunction(maxPercentage max: Double) -> (Double) -> (CGFloat)  {
        guard (max != 0) else { return resultFunction(a: 0, b: 0) }
        let y: CGFloat = 85
        let a = y/CGFloat(max)
        return resultFunction(a: a, b: 25)
    }
    
    
    /// Sumurizing in one Dictionary how much gramms were for each material in given [Model] data.
    /// There's also a Double number – sum of all weights.
    private
    func prepareModelDict(data: [Model]) -> ([Int:Int], Double) {
        var dict: [Int:Int] = [:]
        var sum: Int = 0
        
        for row in 0...data.count-1 {
            
            let material = data[row].logMaterial
            let size = data[row].logSize
            let materialCount = material?.count ?? 1
            
            for item in 0...materialCount-1 {
                let id = material?[item] ?? 0
                if (dict[id] != nil) {
                    dict[id]! += size?[item] ?? 0
                } else {
                    dict[id] = size?[item] ?? 0
                }
                sum += size?[item] ?? 0
            }
        }
        
        return (dict, Double(sum))
    }
    
    
    /// Some weird shit. Must be redeveloped.
    func colorByRowValue(_ value: Int) -> UIColor {
        let useStruct = materialColors.self
        switch value {
        case 0: return useStruct.plastic
        case 1: return useStruct.organic
        case 2: return useStruct.paper
        case 3: return useStruct.metal
        case 4: return useStruct.glass
        case 5: return useStruct.wood
        case 6: return useStruct.fabric
        case 7: return useStruct.battery
        default: return useStruct.lamp
        }
    }
    
    
    /// Some weird shit. Must be redeveloped.
    func iconByRowValue(_ value: Int) -> UIImage {
        let useStruct = materialIcons.self
        switch value {
        case 0: return useStruct.plastic
        case 1: return useStruct.organic
        case 2: return useStruct.paper
        case 3: return useStruct.metal
        case 4: return useStruct.glass
        case 5: return useStruct.wood
        case 6: return useStruct.fabric
        case 7: return useStruct.battery
        default: return useStruct.lamp
        }
    }
}


enum direction {
    case up
    case down
}
