//
//  Identity.swift
//  
//
//  Created by Kayla Hoyet on 7/14/21.
//

import Foundation

public struct HumanIdentity: Codable {
  let dateOfBirth: String?
  let address: Address?
    
  private enum CodingKeys: String, CodingKey {
    case dateOfBirth = "date_of_birth"
    case address
  }
    
}
