//
//  Parser.swift
//  Biniva
//
//  Created by Nick Oltyan on 12.07.2021.
//

import UIKit

class Parser {
    
    let functions = MaterialFunctions()
    
    /// Divides string into array of strings, divided by <tab> prefix.
    func tabParser(text: String) -> [String] {
        return text.components(separatedBy: "<tab>")
    }

    func getArticleText() -> [String] {
        guard Defaults.getIsSubscribed() else {
            return getUnsubscribedText()
        }
        
        var resultArray: [String] = []
        
        for item in prepareArticleData() {
            do {
                let path = Bundle.main.path(forResource: item, ofType: "txt")
                let string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                resultArray.append(string)
            } catch _ {
                print("catch an error")
            }
        }
        
        guard resultArray.count != 0 else {
            return getNoDataText()
        }
        
        return resultArray
    }
    
    private
    func getUnsubscribedText() -> [String] {
        do {
            let path = Bundle.main.path(forResource: "unsubscribed", ofType: "txt")
            let string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            return [string]
        } catch _ {
            print("catch an error")
            return []
        }
    }
    
    private
    func getNoDataText() -> [String] {
        do {
            let path = Bundle.main.path(forResource: "no_data", ofType: "txt")
            let string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            return [string]
        } catch _ {
            print("catch an error")
            return []
        }
    }
    
    
    private
    func prepareArticleData() -> [String] {
        let data: Array<(Int, Double, direction)> = functions.calculateWeekly()
        let itemsForArticle = prepareItemsForArticle(data: data)
        
        var resultArray: [String] = []
        
        for item in itemsForArticle {
            let (material, direction) = item
            resultArray.append("\(material)_intro")
            if direction == .up {
                resultArray.append("\(material)_up")
            } else {
                resultArray.append("\(material)_down")
            }
        }
        
        return resultArray
    }
    
    private
    func prepareItemsForArticle(data: Array<(Int, Double, direction)>) -> [(Int, direction)] {
        var resultArray: [(Int, direction)] = []

        if data.count >= 3 {
            // Add the material that raised the max
            let max = data[0]
            let (materialMax, _, directionMax) = max
            resultArray.append((materialMax, directionMax))
            
            // Add the material thet felt the max
            let min = data[data.count-1]
            let (materialMin, _, directionMin) = min
            resultArray.append((materialMin, directionMin))
            
            // Add the random material between them
            let randomIndex: Int = Int.random(in: 1...data.count-2)
            let randomElement = data[randomIndex]
            print("randomElement: \(randomElement)")
            let (materialRandom, _, directionRandom) = randomElement
            resultArray.append((materialRandom, directionRandom))
            
        } else {
            for element in data {
                let (material, _, direction) = element
                resultArray.append((material, direction))
            }
        }

        resultArray.shuffle() // Shuffle the array to present always new articles for users.
        return resultArray
    }
}
