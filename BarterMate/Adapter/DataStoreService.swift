//
//  DataStoreService.swift
//  BarterMate
//
//  Created by Zico on 14/3/23.
//

import Amplify
import Combine

protocol DataStoreService {

    var eventPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> { get }
    
}
