//
//  DataStoreServiceEvent.swift
//  BarterMate
//
//  Created by Zico on 14/3/23.
//


// TODO: implement functionalities for these events
enum DataStoreServiceEvent {
    case userSynced
    case userSignedIn
    case userSignedOut
    case userLoaded(_ user: User)
    case userUpdated(_ user: User)
    case itemCreated(_ item: Item)
    case itemDeleted(_ item: Item)
    case itemSynced
    case postingCreated(_ posting: Posting)
    case postingDeleted(_ posting: Posting)
    case postingSynced
    case requestCreated(_ request: Request)
    case requestDeleted(_ request: Request)
    case requestSynced
    case chatCreated(_ chat: Chat)
}
