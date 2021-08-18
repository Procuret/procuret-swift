//
//  DealGraph.swift
//  
//
//  Created by Kayla Hoyet on 8/5/21.
//

import Foundation

public struct DealGraph: Codable {
    
    internal static let path = "/deal/graph"
    
    let start: ProcuretTime
    let end: ProcuretTime
    let attribute: DealGraphAttribute
    let groupBy: DealGraphGroupBy
    let yValues: Array<Float>
    let xLabels: Array<String>
    
    private enum CodingKeys: String, CodingKey {
        case start
        case end
        case attribute
        case groupBy
        case yValues = "y_values"
        case xLabels = "x_labels"
    }

}

public struct DealGraphAttribute: Codable {
    
}

public struct DealGraphGroupBy: Codable {
    
}
