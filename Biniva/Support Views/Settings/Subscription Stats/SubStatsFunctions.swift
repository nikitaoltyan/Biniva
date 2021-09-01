//
//  SubStatsFunctions.swift
//  Biniva
//
//  Created by Nick Oltyan on 01.09.2021.
//

import Foundation

class SubStatsFunctions {
    
    let maxUsers = 100.0 // Per year
    let maxGarbage = 4000000.0 // Per year in gramms
    
    
    func calculateUsersBarWidth(current: Double, width: Double) -> Double {
        let result = (current * width)/maxUsers
        if result > width { return width }
        else { return result }
    }
    
    
    func gainedUserNumber() -> Int {
        let start = Defaults.getSubscriptionStart()
        let today = Date.today()
        print("start day: \(start)")
        print("end day: \(today)")
        
        let daysPassed: Double = Double(daysBetween(start: start, end: today))
        let dailyCame = maxUsers/360.0
        let result = Int(dailyCame.rounded() * daysPassed)
        return result
    }
    
    func gainedGarbageNumber() -> Int {
        let start = Defaults.getSubscriptionStart()
        let today = Date.today()
        let daysPassed: Double = Double(daysBetween(start: start, end: today))
        let dailyCame = maxGarbage/360.0 // In gramms
        
        let result = Int(dailyCame.rounded() * daysPassed)
        return result
    }
    
    
    private
    func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
}
