//
//  Document.swift
//  
//
//  Created by Hugh on 20/4/2022.
//

import Foundation


public protocol Document: Codable, Sendable {
    
    static var path: String { get }

    var created: Date { get }
    var body: String { get }
    var asHtml: Bool { get }
    var name: String { get }
    
    static func retrieveLatest(
        asHtml: Bool,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint,
        callback: @Sendable @escaping (Error?, Self?) -> Void
    ) -> Void
    
}


extension Document {
    
    public static func retrieveLatest(
        asHtml: Bool = false,
        session: SessionRepresentative? = nil,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable@escaping (Error?, Self?) -> Void
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
