//
//  ItemFacade.swift
//  BarterMate
//
//  Created by Zico on 2/4/23.
//

import Foundation

protocol ItemFacade {
    var delegate: (any ItemFacadeDelegate)? { get set }
    
    func getItemById(id: Identifier<BarterMateItem>)
}
