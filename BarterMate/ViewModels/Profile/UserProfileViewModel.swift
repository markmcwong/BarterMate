//
//  UserProfileViewModel.swift
//  BarterMate
//
//  Created by Zico on 16/3/23.
//

import Amplify
import Combine
import Foundation

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published private(set) var user: User?
    @Published private(set) var loadedItems: [Item] = []
    @Published private(set) var isItemSynced = false
    
    private var dataStorePublisher: AnyCancellable?
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
        Task {
            do {
                user = try await dataStoreService.query(User.self, byId: "e3a20b7c-b166-4b33-9495-2cbc3f99adf6")
            } catch {
                print("error querying user")
            }

        }
    }
    
    private func onReceive(event: DataStoreServiceEvent) {
        switch event {
        case .userSynced:
            user = dataStoreService.user
            loadItems()
        case .itemSynced:
            //dataStorePublisher?.cancel()
        
            Task {
                await fetchItems(page:0)
            }
            
            isItemSynced = true
        case .itemCreated(let newItem):
            loadedItems.insert(newItem, at: 0)
        case .itemDeleted(let item):
            removeItem(item)
        default:
            break
        }
    }
    
    private func fetchItems(page: Int) async {
        guard user != nil else {
            return
        }
        
        let predicateInput = Item.keys.userID == user?.id
        let sortInput = QuerySortInput.descending(Item.keys.createdAt)
        let paginationInput = QueryPaginationInput.page(UInt(page), limit: 20)
        do {
            let items = try await dataStoreService.query(Item.self,
                                                         where: predicateInput,
                                                         sort: sortInput,
                                                         paginate: paginationInput)
            
            if page != 0 {
                loadedItems.append(contentsOf: items)
            } else {
                loadedItems = items
            }
        } catch let error as AmplifyError {
            Amplify.log.error("\(#function) Error loading posts - \(error.localizedDescription)")
        } catch {
            Amplify.log.error("\(#function) Error loading posts - \(error.localizedDescription)")
        }
    }
    
    private func removeItem(_ item: Item) {
        for i in 0..<loadedItems.count where loadedItems[i].id == item.id {
            loadedItems.remove(at: i)
            break
        }
    }
    
    private func loadItems() {
        guard user != nil else {
            return
        }
        
        Task {
            await fetchItems(page: 0)
        }
        
        dataStorePublisher = dataStoreService.dataStorePublisher(for: Item.self)
            .receive(on: DispatchQueue.main)
            .collect(.byTimeOrCount(DispatchQueue.main, 3.0, 10))
            .sink {
                if case let .failure(error) = $0 {
                    Amplify.log.error("Subscription received error - \(error.localizedDescription)")
                }
            }
            receiveValue: { [weak self] _ in
                guard let self = self else {return}
                Task {
                    await self.fetchItems(page: 0)
                }
            }
        
    }
}
