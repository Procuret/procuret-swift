//
//  RequestData.swift
//
//
//  Created by Hugh Jeremy on 09 Jun 2021
//

import Foundation


internal struct RequestData {
    
    internal let encodedData: Data
    internal let rawData: Encodable
    internal let encodedDataString: String

    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.nozomiTime)
        return encoder
    }()
    
    internal init <T: Encodable>(
        data: T
    ) throws {
        rawData = data
        encodedData = try Self.encoder.encode(data)
        let dataString = String(data: encodedData, encoding: .utf8)
        guard dataString != nil else {
            throw ProcuretAPIError(
                .inconsistentState,
                message: "Unable to cast encoded data to String"
            )
        }
        encodedDataString = String(data: encodedData, encoding: .utf8)!
    }
    
    internal func asQueryStringArgument() throws -> String {
        let b64data = encodedData.base64EncodedString()
        guard let queryString = b64data.addingPercentEncoding(
            withAllowedCharacters: .urlHostAllowed
        ) else {
            throw ProcuretAPIError(
                .inconsistentState,
                message: "Unable to add percent encoding to queryString"
            )
        }
        return queryString
    }
    
    internal static func encode(_ date: Date) -> String {
        return DateFormatter.nozomiTime.string(from: date)
    }

}
