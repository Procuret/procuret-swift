//
//  Request.swift
//
//
//  Created by Hugh Jeremy on 09 Jun 2021
//

import Foundation


internal class Request {
    
    private static let debugDataPrintEnvironmentKey = "PROCURET_DEBUG_DATA"
    private static let agent = "Procuret Swift 1.1.0"
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
    
    public static func make<T: Encodable>(
        path: String,
        payload: T,
        session: SessionRepresentative?,
        query: QueryString?,
        method: HTTPMethod,
        endpoint: ApiEndpoint,
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
            endpoint: endpoint,
            then: callback
        )
        
        return
        
    }
    
    public static func make(
        path: String,
        data: RequestData?,
        session: SessionRepresentative?,
        query: QueryString?,
        method: HTTPMethod,
        endpoint: ApiEndpoint,
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
            request = try Self.buildRequest(
                path,
                data,
                session,
                query,
                method,
                endpoint
            )
        } catch {
            callback(error, nil)
            return
        }
        
        if Self.shouldDebugPrint() {
            Self.debugPrintRequest(
                endpoint: endpoint,
                path: path,
                method: method
            )
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
            if Self.shouldDebugPrint() { Self.debugPrintError(error: error) }
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
            let error = ProcuretAPIError.fromResponse(
                data: data,
                code: httpResponse.statusCode
            )
            if Self.shouldDebugPrint() { Self.debugPrintError(error: error) }
            callback(error, nil)
            return
        }
        callback(nil, data)
        return
    }
    
    private static func buildRequest(
        _ path: String,
        _ data: RequestData?,
        _ session: SessionRepresentative?,
        _ query: QueryString?,
        _ method: HTTPMethod,
        _ endpoint: ApiEndpoint
    ) throws -> URLRequest {

        let fullURL: String

        if let query = query {
            guard let parameters = query.paramString.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) else {
                throw ProcuretAPIError(
                    .inconsistentState,
                    message: "bad url encode"
                )
            }
            fullURL = endpoint.url + path + parameters
        } else {
            fullURL = endpoint.url + path
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
        request.setValue(
            Self.deriveUserAgent(session),
            forHTTPHeaderField: "User-Agent"
        )
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
            
            #if DEBUG
            if let decodeError = error as? DecodingError,
               let rawString = String(data: data, encoding: .utf8)
            {
                print("DecodingError from API JSON \(decodeError)")
                print("--- Raw JSON begins ---")
                print(rawString)
                print("--- Raw JSON ends ---")
            }
            #endif
            
            callback(error, nil)
            return
        }

        callback(nil, decoded)
        
        return
        
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
    
    private static func debugPrintError(error: Error?) -> Void {
        
        guard let error = error else { return }
        
        if let apiError = error as? ProcuretAPIError {
            
            print("-$- Procuret API Error -$- ")
            print(apiError.message)
            print("-$- End Procuret API Error -$-")
            
            return
            
        }
        
        print("-#- Other (non API) Error -#-")
        print(error.localizedDescription)
        print("-#- End Other (non API) Error -#-")
        
        
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
        
        print("-@- Begin raw data returned by Procuret API -@-")
        print(rawString)
        print("-@- End raw data returned by Procuret API -@-")
        
        return

    }
    
    private static func debugPrintRequest(
        endpoint: ApiEndpoint,
        path: String,
        method: HTTPMethod
    ) -> Void {
        
        print("Making request to \(endpoint): \(path)|\(method.rawValue)")
        print("Raw response data (if any) will be printed below.")
        
    }
    
    private static func deriveUserAgent(
        _ session: SessionRepresentative?
    ) -> String {
        
        if let prefix = session?.userAgentPrefix {
            return "\(prefix);\(Self.agent)"
        }
        return Self.agent

    }
    
}
