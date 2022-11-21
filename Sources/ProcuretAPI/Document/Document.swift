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
        asHtml: Bool,
        session: Session?,
        endpoint: ApiEndpoint,
        callback: @escaping (Error?, Self?) -> Void
    ) -> Void
    
}


extension Document {
    
    public static func retrieveLatest(
        asHtml: Bool = false,
        session: Session? = nil,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) -> Void {
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [UrlParameter(asHtml, key: "as_html")]
            ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
}
