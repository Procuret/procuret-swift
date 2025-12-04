//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 9/6/21.
//

import Foundation
import CryptoKit


internal struct Signature: Sendable {
    
    private static let timestampResolution = 900
    
    internal static func make(
        path: String,
        apiKey: Data
    ) throws(ProcuretError) -> String {
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let timekey = timestamp - (timestamp % Self.timestampResolution)
        let stringToHash = String(describing: timekey) + path

        guard let dataToHash = stringToHash.data(using: .utf8) else {
            throw ProcuretError(.other, message: """
Unable to generate bytes Data from string to hash                
""")
        }
        
        let hmac = HMAC<SHA256>.authenticationCode(
            for: dataToHash,
            using: SymmetricKey(data: apiKey)
        )

        let hmacData = Data(hmac)
        let base64 = hmacData.base64EncodedString()
        return base64

    }
    
}
