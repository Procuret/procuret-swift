//
//  ApiEndpoint.swift
//  
//
//  Created by Hugh on 22/11/2022.
//

import Foundation


public struct ApiEndpoint: Codable, Identifiable, Hashable,
                           CustomStringConvertible {
    
    private static let endpointEnvironmentKey = "PROCURET_ENDPOINT"
    
    public static let live = ApiEndpoint(
        domain: .live,
        scheme: .https,
        rootPath: .standard
    )

    public static let demo = ApiEndpoint(
        domain: .demo,
        scheme: .https,
        rootPath: .standard
    )

    private let domain: String
    private let scheme: String
    private let rootPath: String
    
    public var url: String { get {
        return self.scheme + self.domain + self.rootPath
    } }
    
    public var id: String { get { return self.url } }
    public var description: String { get { return self.url } }

    public init(
        domain: ApiDomain,
        scheme: HttpRequestScheme,
        rootPath: ApiRootPath
    ) {
        
        self.domain = domain.rawValue
        self.scheme = scheme.rawValue
        self.rootPath = rootPath.rawValue
        
        return
        
    }
    
    public init(
        customDomain: String,
        customScheme: String,
        customRootPath: String
    ) {
        
        self.domain = customDomain
        self.scheme = customScheme
        self.rootPath = customRootPath
        
        return

    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.url)
        return
    }
    
    public static func fromEnvironmentVariables() -> Self? {
        if let rawVariable = getenv(Self.endpointEnvironmentKey) {
            guard let endpoint = String(utf8String: rawVariable) else {
                fatalError("Bad environment variable")
            }
            let components = endpoint.split(separator: "/", maxSplits: 3)
            return ApiEndpoint(
                customDomain: String(components[1]),
                customScheme: String(components[0]) + "//",
                customRootPath: "/" + String(components[2])
            )
        }
        return nil
    }
    
    public static func fromEnvironmentVariables(defaultTo: Self) -> Self {
        if let defined = Self.fromEnvironmentVariables() {
            return defined
        }
        return defaultTo
    }
    
    public static func forceFromEnvironmentVariables() -> Self {
        guard let endpoint = Self.fromEnvironmentVariables() else {
            fatalError("endpoint environment variable required")
        }
        return endpoint
    }

}
