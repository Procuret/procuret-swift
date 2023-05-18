//
//  PayNowFeeMode.swift
//  
//
//  Created by Hugh on 13/4/2023.
//

import Foundation


public enum PayNowFeeMode: Int, Codable, Hashable, Equatable, CaseIterable {
    
    case customerPays = 1
    case supplierPays = 2

}
