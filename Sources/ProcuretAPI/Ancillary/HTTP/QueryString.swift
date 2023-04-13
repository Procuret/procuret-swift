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
    
    init(_ parameters: Array<UrlParameter>) {
    
        if parameters.count < 1 {
            paramString = ""
            targets = [UrlParameter]()
            return
        }
        
        self.targets = parameters

        var workingString = "?" + String(describing: parameters[0])

        for parameter in targets.dropFirst() {
            workingString += "&" + String(describing: parameter)
        }

        self.paramString = workingString
    
        return

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
