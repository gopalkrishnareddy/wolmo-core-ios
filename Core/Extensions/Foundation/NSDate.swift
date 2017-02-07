//
//  NSDate.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

internal let DefaultDateFormatter: NSDateFormatter = {
    $0.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    $0.dateFormat = "yyyy-MM-dd"
    $0.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    return $0
}(NSDateFormatter())

internal let DefaultWeekDateFormatter: NSDateFormatter = {
    $0.setLocalizedDateFormatFromTemplate("EEEE")
    return $0
}(NSDateFormatter())

public extension NSDate {
    
    /**
     Returns the hours from a date.
        
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: NSCalendar().component()
     - returns: An Int value representing the hours, between 0 - 24.
     */
    public func hours(using calendar: NSCalendar = .currentCalendar()) -> Int {
       return calendar.component(.Hour, fromDate: self)
    }
    
    /**
     Returns the minutes from a date.
     
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: NSCalendar().component()
     - returns: An Int value representing the minutes, between 0 - 60.
     */
    public func minutes(using calendar: NSCalendar = .currentCalendar()) -> Int {
        return calendar.component(.Minute, fromDate: self)
    }
    
    /**
     Returns the seconds from a date.
     
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: NSCalendar().component()
     - returns: An Int value representing the seconds, between 0 - 60.
     */
    public func seconds(using calendar: NSCalendar = .currentCalendar()) -> Int {
        return calendar.component(.Second, fromDate: self)
    }
    
    /**
     Returns the date components specified by `units` from a date.
     
     - parameter units: The units to retrieve. ex: .Second
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: NSCalendar().components()
     - note: You could pass an array to units, such as [.Hour, .Second] to 
     retrieve both components at the same time.
     - returns: The requested date components.
     */
    public func components(units: NSCalendarUnit, using calendar: NSCalendar = .currentCalendar()) -> NSDateComponents {
        return calendar.components(units, fromDate: self)
    }
    
    /**
     Creates a Date from a string.
     
     - parameter dateString: The date string representation.
     - parameter dateFormatter: The used for initializing the date.
     */
    convenience init?(dateString: String, dateFormatter: NSDateFormatter = DefaultDateFormatter) {
        guard let date = dateFormatter.dateFromString(dateString) else {
            return nil
        }
        
        self.init(timeInterval: 0, sinceDate: date)
    }
    
    /**
     Creates a Date from a day, month and year.
     
     - parameters:
        - day: Day of month
        - month: Month of year
        - year: Year
     - seealso: init(dateString: String)
     */
    convenience init?(day: Int, month: Int, year: Int) {
        var monthString: String = "\(month)"
        var dayString: String = "\(day)"
        if month < 10 {
            monthString = "0\(month)"
        }
        if day < 10 {
            dayString = "0\(day)"
        }
        self.init(dateString: "\(year)-\(monthString)-\(dayString)")
    }
    
    /**
     Returns the current day of the week (ex: Monday).
     
     - parameter dateFormatter: The dateFormatter to use.
     */
    public func getWeekDay(dateFormatter: NSDateFormatter = DefaultWeekDateFormatter) -> String {
        return dateFormatter.stringFromDate(self)
    }
    
    /**
     Returns a new date that is set to a given number of days relative to the date.
     
     - parameter days: Quantity of days to add to self.
     - seealso: dateByAddingTimeInterval()
     */
    public func adding(days days: Int) -> NSDate {
        let secondsInDays = Double(days) * 60 * 60 * 24
        return dateByAddingTimeInterval(secondsInDays)
    }
    
    /**
     Returns a new date that is set to a given number of hours relative to the date.
     
     - parameter hours: Quantity of hours to add to self.
     - seealso: dateByAddingTimeInterval()
     */
    public func adding(hours hours: Int) -> NSDate {
        let secondsInHours: NSTimeInterval = Double(hours) * 60 * 60
        return dateByAddingTimeInterval(secondsInHours)
    }
}

extension NSDate: Comparable {}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedDescending
}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return NSCalendar.currentCalendar().compareDate(lhs, toDate: rhs, toUnitGranularity: NSCalendarUnit.Second) == .OrderedSame
}
