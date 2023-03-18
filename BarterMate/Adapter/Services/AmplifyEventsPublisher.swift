//
//  AmplifyEventsPublisher.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

import Foundation
import Combine
import Amplify
import AWSDataStorePlugin

class AmplifyEventsPublisher {
    var dataStoreServiceEventsTopic: PassthroughSubject<DataStoreServiceEvent, DataStoreError>
    
    var user: User?
    var eventsPublisher: AnyPublisher<DataStoreServiceEvent, DataStoreError> {
        return dataStoreServiceEventsTopic.eraseToAnyPublisher()
    }
    private var subscribers = Set<AnyCancellable>()
    
    init() {
        self.dataStoreServiceEventsTopic = PassthroughSubject<DataStoreServiceEvent, DataStoreError>()
    }
    
    func configure() {
        subscribeToDataStoreHubEvents()
    }
}

extension AmplifyEventsPublisher {
    
    private func subscribeToDataStoreHubEvents() {
        Amplify.Hub.publisher(for: .dataStore)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: hubEventsHandler(payload:))
            .store(in: &subscribers)
    }
    
    private func handleModelSyncedEvent(modelSyncedEvent: ModelSyncedEvent) {
        switch modelSyncedEvent.modelName {
        case User.modelName:
            dataStoreServiceEventsTopic.send(.userSynced)
        case Item.modelName:
            dataStoreServiceEventsTopic.send(.itemSynced)
        case Posting.modelName:
            dataStoreServiceEventsTopic.send(.postingSynced)
        case Request.modelName:
            dataStoreServiceEventsTopic.send(.requestSynced)
        default:
            return
        }
    }
    
    private func hubEventsHandler(payload: HubPayload) {
        switch payload.eventName {
        case HubPayload.EventName.DataStore.modelSynced:
            guard let modelSyncedEvent = payload.data as? ModelSyncedEvent else {
                Amplify.log.error(
                    """
                    Failed to case payload of type '\(type(of: payload.data))' \
                    to ModelSyncedEvent.
                    """
                )
                return
            }
            handleModelSyncedEvent(modelSyncedEvent: modelSyncedEvent);
        default:
            return
        }
    }
}

