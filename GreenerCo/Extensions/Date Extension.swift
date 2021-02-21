//
//  Date Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 31.01.2021.
//

import Foundation

extension Date {
    
    /// Returns the day of a month of the current Date.
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    
    /// Returns the text month of the current Date.
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    
    /// Returns the year of the current Date.
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
    
    
    /// Function returns Array with  names of 7 last logged days (chronologically, just dates, may be empty in Firebase).
    /// - warning: Not working for 6 first days of each new year.
    /// - warning: Empty
    var sevenDaysDict: Dictionary<Int,Int> {
        var returnDict: Dictionary<Int,Int> = [:]
        let cal = Calendar.current
        let todayDayOfTheYear = cal.ordinality(of: .day, in: .year, for: self)!
        for i in (todayDayOfTheYear-6)...todayDayOfTheYear{
            returnDict[i] = 0
        }
        return returnDict
    }
    
    
    static func stringDayName(day: Int) -> String {
        let yearFormatter  = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        let year = Int(yearFormatter.string(from: Date()))
        let da = Calendar.current.date(from: DateComponents(year: year, month: 1, day: day))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d_MMMM_YYYY"
        return dateFormatter.string(from: da!)
    }
}
