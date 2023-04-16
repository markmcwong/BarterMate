//
//  UserFacade.swift
//  BarterMate
//
//  Created by Zico on 27/3/23.
//

import Foundation

protocol UserFacade {
    var delegate: (any UserFacadeDelegate)? { get set }

    func getUserById(id: Identifier<BarterMateUser>)
}
