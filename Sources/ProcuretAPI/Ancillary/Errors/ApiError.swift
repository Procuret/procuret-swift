//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 9/6/21.
//

import Foundation



public struct ProcuretAPIError: ProcuretError {

    public let kind: Kind
    public let message: String
    public let id: String
    
    internal init(_ kind: Kind, message: String? = nil) {
        self.kind = kind
        self.message = message ?? kind.rawValue
        self.id = RandomNumber(.large).string
        return
    }

    public enum Kind: String {
        case jsonParseFailed = """
        Procuret API Swift was unable to parse the JSON sent by the Procuret API. \
        This likely indicates a bug, please considering opening an issue on \
        GitHub.
        """
        case badResponse = """
        Procuret API Swift library was not able to understand the response sent \
        by the Procuret API. If this happens repeatedly, there may be a bug in \
        the API.
        """
        case inconsistentState = """
        Procuret API Swift has entered an unexpected state from which it cannot \
        recover. Please consider filing a bug report on GitHub.
        """
        case notFound = "A requested resource could not be found"
        case notAuthorised = """
        You are not authorised to access a requested resource.
        """
        case notAuthenticated = """
        Your request was not authenticated. Your Session may have expired or \
        been deleted. Consider creating a new Session.
        """
        case badRequest = """
        The Procuret API could not understand your request, it may be missing a \
        required parameter, or be composed of incorrect types. It is the \
        responsibility of this library (Procuret API Swift) to supply correctly \
        formed requests, so please consider filing a bug report on GitHub.
        """
        case contentTooLarge = """
        Your request exceeded a size limit imposed by the Procuret API.
        """
        case unprocessable = """
        The Procuret API could not process your request, it may have containe\
        d data that violated a condition of processing, or which in combinatio\
        n with existing data may have violated a constraint.
        """
        case genericServerError = """
        The Procuret API replied with a generic error response, indicating that \
        it has failed internally. Either Procuret is experiencing temporary \
        disruption, or there is a bug in the API.
        """
        case constraintViolated = """
        Input data violates a constraint. For example, a description may be \
        too long.
        """
        case subscriptionProblem = """
        Your Procuret subscription does not allow you to perfom this action. \
        Your payment method may have expired, or your plan may be disabled. \
        Please visit https://procuret.com/billing or contact support@procuret.com
        """
        case serviceDisruption = """
        Procuret is experiencing a service disruption. This should be \
        temporary. Check the @Procuretapi Twitter feed and \
        https://procuret.com/blog/ for service updates.
        """
        case rateLimit = """
        You have hit the Procuret API rate limiter. You might try batching your \
        requests (e.g. creating 10 Transactions at once). If your \
        implementation requires a higher rate limit, or your believe you are \
        being erroneously limited (e.g. behind a corporate or university NAT), \
        please contact support@procuret.com
        """
        case notImplemented = """
        The requested functionality is not yet implemented by Procuret API Swift
        """
        case badConfiguration = """
        Procuret API is not configured in such a way as to allow it to
        peform your request. You may be missing an environment variable.
        """
        case testError = """
        A test case has entered an unexpected state
        """
    }
    
    private struct ErrorBody: Decodable {
        let errorInformation: String
        let responseCode: Int
        
        private enum CodingKeys: String, CodingKey {
            case errorInformation = "error-information"
            case responseCode = "response-code"
        }
    }
    
    internal static func fromResponse(
        data: Data?,
        code: Int
    ) -> Self {
        
        func deriveKind(code: Int) -> Self.Kind {
            
            switch code {
            case 400: return .badRequest
            case 401: return .notAuthenticated
            case 402: return .subscriptionProblem
            case 403: return .notAuthorised
            case 404: return .notFound
            case 413: return .contentTooLarge
            case 422: return .unprocessable
            case 429: return .rateLimit
            case 500: return .genericServerError
            case 502, 503, 504: return .serviceDisruption
            default: return .inconsistentState
            }
            
        }
        
        let kind = deriveKind(code: code)
        let errorBody: ErrorBody
        
        guard let data = data else { return Self(kind, message: nil) }
        
        do {
            let decoder = JSONDecoder()
            errorBody = try decoder.decode(Self.ErrorBody.self, from: data)
        } catch {
            return Self(kind, message: nil)
        }
        
        return Self(kind, message: errorBody.errorInformation)

    }
    
}
