//
//  UnderpinnedByMethodKernel.swift
//  
//
//  Created by Hugh Jeremy on 27/3/2022.
//

import Foundation


public protocol UnderpinnedByMethodKernel: Decodable, Identifiable, Equatable {
    
    var kernel: PaymentMethodKernel { get }
    
    var publicId: String { get }
    var entityId: Int? { get }
    var created: Date { get }
    var creatingAgentId: Int { get }
    var authorityAgentId: Int { get }
    var instrument: Instrument { get }
    var custodian: Custodian { get }
    var disposition: Disposition { get }
    
    var friendlyDescription: String { get }
    var endsIn: String { get }

}

extension UnderpinnedByMethodKernel {
    
    public var publicId: String { get { return self.kernel.publicId } }
    public var entityId: Int? { get { return self.kernel.entityId } }
    public var created: Date { get { return self.kernel.created } }
    public var creatingAgentId: Int { get { return self.kernel.creatingAgentId } }
    public var authorityAgentId: Int { get { return self.kernel.authorityAgentId } }
    public var instrument: Instrument { get { return self.instrument } }
    public var custodian: Custodian { get { return self.custodian } }
    public var disposition: Disposition { get { return self.disposition } }
    
    public var id: String { get { return self.kernel.publicId } }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.publicId == rhs.publicId
    }

    public static func != (lhs: Self, rhs: Self) -> Bool {
        return lhs.publicId != rhs.publicId
    }


}
