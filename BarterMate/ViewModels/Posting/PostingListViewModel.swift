//
//  PostingListViewModel.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import Combine
import Foundation
import Amplify

class PostingListViewModel: ObservableObject {
    @Published private(set) var loadedPostings: [Posting] = [Posting]()
    @Published var isPostingSynced = false
    
    private var subscribers = Set<AnyCancellable>()
    
    var dataStoreService: DataStoreService
    
    init(manager: ServiceManager = AppServiceManager.shared) {
        self.dataStoreService = manager.dataStoreService
        dataStoreService.eventsPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [ weak self ] completion in
            
            }, receiveValue: { [ weak self ] event in
                self?.onReceive(event: event)
            })
            .store(in: &subscribers)
    }
    
    func onReceive(event: DataStoreServiceEvent) {
        switch event {
        case .postingSynced:
            Task {
                await fetchPostings(page: 0)
            }
        case .postingDeleted(let posting):
            deletePosting(posting)
        default:
            return
        }
    }
    
    func deletePosting(_ posting: Posting) {
        for index in 0 ..< loadedPostings.count {
            guard loadedPostings[index].id == posting.id else {
                continue
            }
            loadedPostings.remove(at: index)
            break
        }
    }
    
    func fetchPostings(page: Int) async {
        let sortInput = QuerySortInput.descending(Posting.keys.createdAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 20)
        do {
            let postings = try await dataStoreService.query(Posting.self,
                                                         where: nil,
                                                         sort: sortInput,
                                                         paginate: paginationInput)
            
            if page != 0 {
                loadedPostings.append(contentsOf: postings)
            } else {
                loadedPostings = postings
            }
        } catch let error as AmplifyError {
            Amplify.log.error("\(#function) Error loading request - \(error.localizedDescription)")
        } catch {
            Amplify.log.error("\(#function) Error loading request - \(error.localizedDescription)")
        }
    }
}
