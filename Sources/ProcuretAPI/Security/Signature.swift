//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 9/6/21.
//

import Foundation
import CryptoKit


internal struct Signature {
    
    private static let timestampResolution = 900
    
    internal static func make(
        path: String,
        apiKey: Data
    ) throws -> String {
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let timekey = timestamp - (timestamp % Self.timestampResolution)
        let stringToHash = String(describing: timekey) + path

        let hmac = HMAC<SHA256>.authenticationCode(
            for: stringToHash.data(using: .utf8)!,
            using: SymmetricKey(data: apiKey)
        )

        let hmacData = Data(hmac)
        let base64 = hmacData.base64EncodedString()
        return base64

    }
    
}
