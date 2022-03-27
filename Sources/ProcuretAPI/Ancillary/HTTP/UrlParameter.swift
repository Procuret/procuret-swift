//
//  UrlParameter.swift
//
//
//  Created by Hugh Jeremy on 09 Jun 2021
//

import Foundation


internal struct UrlParameter {

    internal let key: String
    internal let value: String

    init(_ value: String, key: String) {
        self.key = key
        self.value = value
        return
    }
    
    init(_ value: Int, key: String) {
        self.key = key
        self.value = String(value)
        return
    }
    
    init(_ value: Int64, key: String) {
        self.key = key
        self.value = String(value)
        return
    }

    init(_ value: Bool, key: String) {
        
        self.key = key
        switch value {
        case true:
            self.value = "true"
        case false:
            self.value = "false"
        }
        return
    }
    
    init(_ value: Date, key: String) {
        self.key = key
        self.value = RequestData.encode(value)
        return
    }
    
    init<E: RawRepresentable>(
        _ value: E,
        key: String
    ) where E.RawValue == String {
        self.key = key
        self.value = value.rawValue
    }
    
    init<E: RawRepresentable>(
        _ value: E,
        key: String
    ) where E.RawValue == Int {
        self.key = key
        self.value = String(value.rawValue)
    }
    
    internal static func optionally(
        _ value: String?,
        key: String
    ) -> Self? {
        guard let value = value else { return nil }
        return Self(value, key: key)
    }
    
    internal static func optionally(
        _ value: Int?,
        key: String
    ) -> Self? {
        guard let value = value else { return nil }
        return Self(value, key: key)
    }
    
    internal static func optionally(
        _ value: Int64?,
        key: String
    ) -> Self? {
        guard let value = value else { return nil }
        return Self(value, key: key)
    }
    
    internal static func optionally(
        _ value: Bool?,
        key: String
    ) -> Self? {
        guard let value = value else { return nil }
        return Self(value, key: key)
    }
    
    internal static func optionally<E: RawRepresentable>(
        _ value: E?,
        key: String
    ) -> Self? where E.RawValue == String {
        guard let value = value else { return nil }
        return Self(value, key: key)
    }
    
    internal static func optionally<E: RawRepresentable>(
        _ value: E?,
        key: String
    ) -> Self? where E.RawValue == Int {
        guard let value = value else { return nil }
        return Self(value, key: key)
    }
    
    internal static func createSequence(
        key: String,
        values: [String]
    ) -> [UrlParameter] {
        let targets = values.map { UrlParameter($0, key: key) }
        return targets
    }
    
    internal static func createSequence(
        key: String,
        values: [Int]
    ) -> [UrlParameter] {
        let targets = values.map { UrlParameter($0, key: key) }
        return targets
    }

}

extension UrlParameter: CustomStringConvertible {

    var description: String {
        return self.key + "=" + self.value
    }
}

extension UrlParameter: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(value)
    }
    
    static func == (lhs: UrlParameter, rhs: UrlParameter) -> Bool {
        return lhs.key == rhs.key && lhs.value == rhs.value
    }
}
