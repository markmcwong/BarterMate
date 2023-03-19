//
//  RequestListViewModel.swift
//  BarterMate
//
//  Created by Zico on 16/3/23.
//

import Amplify
import Combine
import Foundation

@MainActor
class RequestListViewModel: ObservableObject {
    @Published private(set) var loadedRequests: [Request] = [Request]()
    @Published var isRequestSynced = false
    
    private var subscribers = Set<AnyCancellable>()

    var requestService: RequestService
    
    init(manager: ServiceManager = AppServiceManager.shared) {
        self.requestService = manager.requestService
        requestService.eventsPublisher.toAnyPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [ weak self ] completion in
            
            }, receiveValue: { [ weak self ] event in
                self?.onReceive(event: event)
            })
            .store(in: &subscribers)
    }
    
    func onReceive(event: DataStoreServiceEvent) {
        switch event {
        case .requestSynced:
            Task {
                await fetchRequests(page: 0)
            }
        case .requestDeleted(let request):
            deleteRequest(request)
        default:
            return
        }
    }
    
    func deleteRequest(_ request: Request) {
        for index in 0 ..< loadedRequests.count {
            guard loadedRequests[index].id == request.id else {
                continue
            }
            loadedRequests.remove(at: index)
            break
        }
    }
    
    func fetchRequests(page: Int) async {
        let sortInput = QuerySortInput.descending(Request.keys.createdAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 20)
        do {
            let requests = try await requestService.query(where: nil,
                                                          sort: sortInput,
                                                          paginate: paginationInput)
            
            if page != 0 {
                loadedRequests.append(contentsOf: requests)
            } else {
                loadedRequests = requests
            }
        } catch let error as AmplifyError {
            Amplify.log.error("\(#function) Error loading request - \(error.localizedDescription)")
        } catch {
            Amplify.log.error("\(#function) Error loading request - \(error.localizedDescription)")
        }
    }
}

