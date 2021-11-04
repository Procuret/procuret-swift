//
//  Date.swift
//  
//
//  Created by Hugh Jeremy on 09 Jun 2021
//


import Foundation

public struct ProcuretDate: Codable {
    let year: Int
    let month: Int
    let day: Int
}


extension DateFormatter {
    
    static let nozomiTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}
