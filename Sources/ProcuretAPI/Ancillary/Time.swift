//
//  Time.swift
//  
//
//  Created by Kayla Hoyet on 7/22/21.
//  Modified by Hugh Jeremy 27 Mar 2022
//

import Foundation


extension DateFormatter {
    
    public static let nozomiTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}
