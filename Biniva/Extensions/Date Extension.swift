//
//  Date Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 31.01.2021.
//

import Foundation

extension Date {
    
    /// Returns only a date without time. Useable for CoreData.
    /// - warning: optional
    var onlyDate: Date? {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date
    }
    
    /// Returns only a Date of the previous day.
    /// - warning: Optional is already opened. So that can be today Date.
    var dayBefore: Date {
            return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        }
    
    /// Returns only a Date of the next day.
    /// - warning: Optional is already opened. So that can be today Date.
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    }
    
    
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
    
    /// - warning: Convert into day and month (like: "6 March")
    var inString: String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "d MMMM"
        return formatter3.string(from: self)
    }
    
    
    // WTF ?!?!?!
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
    
    static func stringWeekdayName(day: Int) -> String {
        let yearFormatter  = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        let year = Int(yearFormatter.string(from: Date()))
        let da = Calendar.current.date(from: DateComponents(year: year, month: 1, day: day))
        let weekdayFormatter  = DateFormatter()
        weekdayFormatter.dateFormat = "EE"
        return weekdayFormatter.string(from: da!)
    }
}
