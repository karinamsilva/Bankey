//
//  Date+Utils.swift
//  Bankey
//
//  Created by Karina on 21/08/22.
//

import Foundation

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
