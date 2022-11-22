//
//  Designated.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//  Modified by Hugh Jeremy on 28 Mar 2022
//

import Foundation

public struct DesignatedPaymentMethod {
    
    internal static let path = PaymentSeries.path + "/designated-method"
    
    public static func create<GenericMethod: IdentifiesPaymentMethod>(
        session: SessionRepresentative,
        series: PaymentSeries,
        method: GenericMethod,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                seriesId: series.publicId,
                methodId: method.paymentMethodId
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            callback(error)
            return
        }
    }
        
    private struct CreatePayload: Codable {
        let seriesId: String
        let methodId: String
            
        private enum CodingKeys: String, CodingKey {
            case seriesId = "series_id"
            case methodId = "method_id"
        }
    }

}
