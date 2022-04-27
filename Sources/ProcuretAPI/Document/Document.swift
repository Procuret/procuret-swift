//
//  Document.swift
//  
//
//  Created by Hugh on 20/4/2022.
//

import Foundation


public protocol Document: Codable {
    
    static var path: String { get }

    var created: Date { get }
    var body: String { get }
    var asHtml: Bool { get }
    var name: String { get }
    
    static func retrieveLatest(
        callback: @escaping (Error?, Self?) -> Void,
        asHtml: Bool,
        session: Session?
    ) -> Void
    
    
    
}


extension Document {
    
    public static func retrieveLatest(
        callback: @escaping (Error?, Self?) -> Void,
        asHtml: Bool = false,
        session: Session? = nil
    ) -> Void {
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [UrlParameter(asHtml, key: "as_html")]
            ),
            method: .GET
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
        
    }
    
    
}
