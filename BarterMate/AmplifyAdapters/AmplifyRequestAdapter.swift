//
//  AmplifyRequestAdapter.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import Foundation

struct AmplifyRequestAdapter {
    
    static func toBarterMateModel(request: Request) -> BarterMateRequest? {
        guard let description = request.description,
              let createdAt = request.createdAt,
              let updatedAt = request.updatedAt else {
            return nil
        }
        
        
        
        let barterMateRequest = BarterMateRequest(id: Identifier(value: request.id),
                                  description: description,
                                  ownerId: Identifier<BarterMateUser>(value: request.userID),
                                  createdAt: createdAt.foundationDate,
                                  updatedAt: updatedAt.foundationDate)
        
        return barterMateRequest
    }
    
    static func toAmplifyModel(request: BarterMateRequest) -> Request {
        let amplifyItem = Request(id: request.id.value,
                                   description: request.description,
                                   userID: request.ownerId.value)
        
        return amplifyItem
    }
}
