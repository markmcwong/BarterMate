//
//  EventsPublisher.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Foundation
import Combine
import Amplify

protocol EventsPublisher {
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> { get }
    
    func dataStorePublisher<M: Model>(for model: M.Type)
    -> AnyPublisher<AmplifyAsyncThrowingSequence<MutationEvent>.Element, Error>
}
