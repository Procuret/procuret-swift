//
//  Request.swift
//
//
//  Created by Hugh Jeremy on 09 Jun 2021
//

import Foundation


internal class Request {
    
    private static let endpointEnvironmentKey = "PROCURET_ENDPOINT"
    private static let debugDataPrintEnvironmentKey = "PROCURET_DEBUG_DATA"
    private static let agent = "Procuret API Swift 0.0.1"
    private static let liveApiEndpoint = "https://procuret.com/api"
    private static let apiSession = URLSession(
        configuration: URLSessionConfiguration.ephemeral
    )
    private static let signatureHeaderName = "X-Procuret-Signature"
    private static let sessionIdHeaderName = "X-Procuret-Session-ID"
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.nozomiTime)
        return decoder
    }()

    private static var apiEndpoint: String {
        get {
            if let eEnvEndpoint = getenv(Self.endpointEnvironmentKey) {
                guard let envEndpoint = String(utf8String: eEnvEndpoint) else {
                    fatalError("Unable to parse environment endpoint")
                }
                return envEndpoint
            }
            return Self.liveApiEndpoint
        }
    }
    
    public static func make<T: Encodable>(
        path: String,
        payload: T,
        session: Session?,
        query: QueryString?,
        method: HTTPMethod,
        then callback: @escaping (Error?, Data?) -> Void
    ) {
        
        let data: RequestData
        do { try data = RequestData(data: payload) }
        catch { callback(error, nil); return }
        
        Self.make(
            path: path,
            data: data,
            session: session,
            query: query,
            method: method,
            then: callback
        )
        
        return
        
    }
    
    public static func make(
        path: String,
        data: RequestData?,
        session: Session?,
        query: QueryString?,
        method: HTTPMethod,
        then callback: @escaping (Error?, Data?) -> Void
    ) {
        
        if method == .GET && data != nil {
            callback(ProcuretAPIError(
                .inconsistentState,
                message: "data parameter must be nil when making a GET request"
            ), nil)
        }

        let request: URLRequest
        
        do {
            request = try buildRequest(
                path,
                data,
                session,
                query,
                method
            )
        } catch {
            callback(error, nil)
            return
        }
        
        if Self.shouldDebugPrint() {
            Self.debugPrintRequest(path: path, method: method)
        }

        let _ = Self.apiSession.dataTask(
            with: request,
            completionHandler: {(
                data: Data?,
                response: URLResponse?,
                error: Error?
            ) in
                Self.completeRequest(data, response, error, callback)
        }).resume()

    }
    
    private static func completeRequest(
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?,
        _ callback: @escaping (Error?, Data?) -> Void
    ) {
        if error != nil {
            callback(error, nil)
            return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            callback(ProcuretAPIError(
                .inconsistentState,
                message: "Could not cast HTTPURLResponse"
            ), nil)
            return
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            let error: ProcuretAPIError
            switch httpResponse.statusCode {
            case 400: error = ProcuretAPIError(.badRequest)
            case 401: error = ProcuretAPIError(.notAuthenticated)
            case 402: error = ProcuretAPIError(.subscriptionProblem)
            case 403: error = ProcuretAPIError(.notAuthorised)
            case 404: error = ProcuretAPIError(.notFound)
            case 429: error = ProcuretAPIError(.rateLimit)
            case 500: error = ProcuretAPIError(.genericServerError)
            case 502, 503, 504: error = ProcuretAPIError(.serviceDisruption)
            default: error = ProcuretAPIError(
                    .inconsistentState,
                    message: "Error code outside known bounds"
                )
            }
            callback(error, nil)
            return
        }
        callback(nil, data)
        return
    }
    
    private static func buildRequest(
        _ path: String,
        _ data: RequestData?,
        _ session: Session?,
        _ query: QueryString?,
        _ method: HTTPMethod
    ) throws -> URLRequest {

        let fullURL: String
        let endpoint = Self.deriveEndpoint()

        if let query = query {
            guard let parameters = query.paramString.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) else {
                throw ProcuretAPIError(
                    .inconsistentState,
                    message: "bad url encode"
                )
            }
            fullURL = endpoint + path + parameters
        } else {
            fullURL = endpoint + path
        }
        
        guard let targetURL = URL(string: fullURL) else {
            throw ProcuretAPIError(
                .inconsistentState,
                message: "nil targetURL"
            )
        }

        var request = URLRequest(url: targetURL)
        request.httpMethod = method.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
        request.setValue(agent, forHTTPHeaderField: "User-Agent")
        request.httpShouldHandleCookies = false
        if data != nil {
            request.setValue(
              "application/json",
              forHTTPHeaderField: "Content-Type"
            )
            request.httpBody = data!.encodedData
        }

        if let session = session {
            let signature = try Signature.make(
                path: path,
                apiKey: session.apiKey.data(using: .utf8)!
            )
            request.setValue(
                signature,
                forHTTPHeaderField: signatureHeaderName
            )
            request.setValue(
                String(session.sessionId),
                forHTTPHeaderField: sessionIdHeaderName
            )
        }

        return request
    }
    
    internal static func decodeResponse<T: Decodable>(
        _ error: Error?,
        _ data: Data?,
        _ decodableType: T.Type,
        _ callback: (Error?, T?) -> Void,
        _ coerce404toNil: Bool = true
    ) -> Void {
        
        if Self.shouldDebugPrint() {
            Self.debugPrintData(data: data)
        }
        
        guard let data = data else {
            if let apiError = error as? ProcuretAPIError {
                if apiError.kind == .notFound && coerce404toNil {
                    callback(nil, nil)
                    return
                }
            }
            callback(error ?? ProcuretAPIError(
                .inconsistentState,
                message: "No data and no error available for decode"
            ), nil)
            return
        }
        
        let decoded: T
        
        do {
            try decoded = Self.decoder.decode(decodableType, from: data)
        } catch {
            callback(error, nil)
            return
        }

        callback(nil, decoded)
        
        return
        
    }
    
    private static func deriveEndpoint() -> String {
        if let environment = getenv("Procuret_API_ENDPOINT") {
            guard let endpoint = String(utf8String: environment) else {
                fatalError("Bad environment variable")
            }
            return endpoint
        }
        return Self.apiEndpoint
    }
    
    private static func shouldDebugPrint() -> Bool {
        if let dValue = getenv(Self.debugDataPrintEnvironmentKey) {
            guard let value = String(utf8String: dValue) else {
                fatalError("Bad data debug print environment variable")
            }
            if value == "true" {
                return true
            }
        }
        return false
    }
    
    private static func debugPrintData(data: Data?) -> Void {
        
        guard let data = data else {
            print("Procuret API returned no data")
            return
        }
        
        guard let rawString = String(data: data, encoding: .utf8) else {
            print("Unable to decode returned data as a UTF-8 string")
            return
        }
        
        print("--- Begin raw data returned by Procuret API ---")
        print(rawString)
        print("--- End raw data returned by Procuret API ---")
        
        return

    }
    
    private static func debugPrintRequest(
        path: String,
        method: HTTPMethod
    ) -> Void {
        
        print("Making request to Procuret API: \(path)|\(method.rawValue)")
        print("Raw response data (if any) will be printed below.")
        
    }
    
}
