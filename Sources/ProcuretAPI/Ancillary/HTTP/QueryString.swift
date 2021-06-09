//
//  QueryString.swift
//
//
//  Created by Hugh Jeremy on 19/12/19.
//

import Foundation


internal struct QueryString: CustomStringConvertible {

    let targets: [UrlParameter]
    let paramString: String
    var description: String {
        return paramString
    }

    init(targetsOnly: [UrlParameter]) {
        
        if targetsOnly.count < 1 {
            paramString = ""
            targets = [UrlParameter]()
            return
        }
        
        targets = targetsOnly
        var workingString = "?" + String(describing: targets[0])
        for target in targets.dropFirst() {
            workingString += "&" + String(describing: target)
        }
        paramString = workingString
        return
    }

    init(fromRawQuery query: String) {
        paramString = query
        targets = [UrlParameter]()
        return
    }

}
