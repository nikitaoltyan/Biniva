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
    
    func getDate() -> String {
        let start = Defaults.getSubscriptionStart()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: start)
        let year = components.year
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: start)
        
        return "\(NSLocalizedString("sub_stats_time_since", comment: "")) \(monthString) \(year ?? 0000)"
    }
    
    
    func gainedUserNumber() -> Int {
        let start = Defaults.getSubscriptionStart()
        let today = Date.today()
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
