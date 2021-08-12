//
//  Date Extension.swift
//  GreenerCo
//
//  Created by Никита Олтян on 31.01.2021.
//

import Foundation

extension Date {
    
    /// Returns only a date without time. Useable for CoreData.
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
    
    
    static func today() -> Date {
        return Date().onlyDate!
    }

    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.next, weekday, considerToday: considerToday)
    }

    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.previous, weekday, considerToday: considerToday)
    }

    func get(_ direction: SearchDirection,
            _ weekDay: Weekday,
            considerToday consider: Bool = false) -> Date {

        let dayName = weekDay.rawValue

        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

        let calendar = Calendar(identifier: .gregorian)

        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
          return self
        }

        var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
        nextDateComponent.weekday = searchWeekdayIndex

        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)

        return date!.onlyDate!
      }
    
    private
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }

    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }

    enum SearchDirection {
        case next
        case previous

        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
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
