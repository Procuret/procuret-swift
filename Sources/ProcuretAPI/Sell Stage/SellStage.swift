//
//  File.swift
//  
//
//  Created by Kayla Hoyet on 11/12/21.
//

import Foundation

public struct SellStage: Decodable {
    
    let human: Human?
    let entity: Entity?
    let supplier: Supplier
    let rateGroup: TermRateGroup?
    let rates: Array<TermRate>
    let termsOfService: TOS
    let privacyPolicy: PrivacyPolicy
    let stripeDDR: StripeDDRAgreement
    let instalmentLink: InstalmentLink?
    let methods: Array<PaymentMethod>
    
    private enum CodingKeys: String, CodingKey {
        case human
        case entity
        case supplier
        case rateGroup = "rate_group"
        case rates
        case termsOfService = "terms_of_service"
        case privacyPolicy = "privacy_policy"
        case stripeDDR = "stripe_ddr"
        case instalmentLink = "instalment_link"
        case methods
    }
}


/*
 
 
 class ProspectivePayNowFee {

     static get path() { return '/pay-now-transaction/fee/prospective'; }

     constructor(
         amount,       // Amount
         percentage,   // String
         feeMode       // PayNowFeeMode
     ) {

         this._amount = amount;
         this._percentage = percentage;
         this._feeMode = feeMode;

         return;

     }

     get amount() { return this._amount; }
     get percentage() { return this._percentage; }
     get supplierPays() {
         return this._feeMode.equalTo(PayNowFeeMode.SUPPLIER_PAYS);
     }
     get customerPays() {
         return this._feeMode.equalTo(PayNowFeeMode.CUSTOMER_PAYS);
     }
     get feeMode() { return this._feeMode; }

     static decode(
         data  // Object<String, Any>
     ) {  // -> Self

         return new ProspectivePayNowFee(
             Amount.decode(data['amount']),
             data['percentage'],
             PayNowFeeMode.decode(data['fee_mode'])
         );

     }

     static retrieve(
         callback,     // Function<Error?, Self?>
         supplierId,   // String
         amount,       // Amount
         divisions,    // ProspectiveDivision
         session=null  // Optional<Session>
     ) {

         const Self = ProspectivePayNowFee;

         if (amount.magnitude < 100) { throw Error('minimum magnitude 100'); }

         ApiRequest.make(
             Self.path,
             'POST',
             null,
             {
                 'supplier_id': supplierId,
                 'amount': amount.encode(),
                 'divisions': divisions.map((d) => { return d.encode(); })
             },
             (e, d) => { ApiRequest.decodeResponse(e, d, callback, Self); },
             session
         );

         return;

     }

 }

 */
