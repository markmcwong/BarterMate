//
//  ChatListViewModel.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Combine
import Foundation
import Amplify

@MainActor
class ChatListViewModel: ObservableObject {
    @Published private(set) var loadedPostings: [Chat] = [Chat]()
    @Published var isPostingSynced = false
    
    private var subscribers = Set<AnyCancellable>()
    
    var chatService: ChatService
    
    init(manager: ServiceManager = AppServiceManager.shared) {
        self.chatService = manager.chatService
//        manager.eventsPublisher.toAnyPublisher
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [ weak self ] completion in
//
//            }, receiveValue: { [ weak self ] event in
//                self?.onReceive(event: event)
//            })
//            .store(in: &subscribers)
    }
    
    func onReceive(event: DataStoreServiceEvent) {
//        switch event {
//        case .postingSynced:
//            Task {
//                await fetchChat(page: 0)
//            }
//        case .postingDeleted(let posting):
//            deletePosting(posting)
//        default:
//            return
//        }
    }
    
    func deletePosting(_ posting: Posting) {
//        for index in 0 ..< loadedPostings.count {
//            guard loadedPostings[index].id == posting.id else {
//                continue
//            }
//            loadedPostings.remove(at: index)
//            break
//        }
    }
    
    func fetchChats(page: Int) async {
//        let sortInput = QuerySortInput.descending(Posting.keys.createdAt)
//        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 20)
//        do {
//            let postings = try await postingService.query(where: nil,
//                                                          sort: sortInput,
//                                                          paginate: paginationInput)
//
//            if page != 0 {
//                loadedPostings.append(contentsOf: postings)
//            } else {
//                loadedPostings = postings
//            }
//        } catch let error as AmplifyError {
//            Amplify.log.error("\(#function) Error loading request - \(error.localizedDescription)")
//        } catch {
//            Amplify.log.error("\(#function) Error loading request - \(error.localizedDescription)")
//        }
    }
}


