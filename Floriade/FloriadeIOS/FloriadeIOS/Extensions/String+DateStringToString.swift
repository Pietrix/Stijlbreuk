//
//  String+DateStringToString.swift
//  FloriadeIOS
//
//  Created by Noah Koole on 22/03/2022.
//

import Foundation

// Only works when supplied with a correct formatted date string
extension String {
    static func DateFromString(dateString: String) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatterGet.date(from: dateString) else {
            fatalError()
        }
        
        return date
    }
    
    static func StringFromDate(date: Date) -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"

        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    
    static func FormatDateFromStringToString(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        
        if let date = dateFormatterGet.date(from: dateString) {
            return dateFormatterPrint.string(from: date)
        } else {
            return "Error"
        }
    }
    
    static func FormatDayDateFromStringToString(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MMM dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd"
        
        if let date = dateFormatterGet.date(from: dateString) {
            return dateFormatterPrint.string(from: date)
        } else {
            return "Error"
        }
    }
    static func FormatMonthDateFromStringToString(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MMM dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM"
        
        if let date = dateFormatterGet.date(from: dateString) {
            return dateFormatterPrint.string(from: date)
        } else {
            return "Error"
        }
    }
}

