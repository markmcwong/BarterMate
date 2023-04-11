//
//  AddRequestViewModel.swift
//  BarterMate
//
//  Created by Zico on 6/4/23.
//

import Combine

class AddRequestViewModel: ObservableObject {
    @Published var description: String = ""
    @Published var errorMessage = ""
    @Published var requestList: ModelList<BarterMateRequest>
    let ownerId: Identifier<BarterMateUser>
    
    init(ownerId: Identifier<BarterMateUser>, requestList: ModelList<BarterMateRequest>) {
        self.ownerId = ownerId
        self.requestList = requestList
    }
    
    func addRequest() {
        guard validateRequest() else {
            return
        }
        
        let newRequest = BarterMateRequest(description: description,
                                           ownerId: ownerId,
                                           createdAt: .now,
                                           updatedAt: .now)
        
        requestList.saveItem(element: newRequest)
    }
    
    private func validateRequest() -> Bool {
        guard description != "" else {
            return false
        }
        
        return true
    }
    
}


