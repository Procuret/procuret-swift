//
//  Time.swift
//  
//
//  Created by Kayla Hoyet on 7/22/21.
//

import Foundation

public struct ProcuretTime: Codable {
    
    public let dateTime: String
}

extension DateFormatter {
    
    static let tableShortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
        
    }()
}
