import Foundation
import Combine

class UserProfileViewModel: ObservableObject {

    @Published private(set) var user: BarterMateUser
    @Published private(set) var itemList: ModelList<BarterMateItem>
    @Published private(set) var postingList: ModelList<BarterMatePosting>
    @Published private(set) var requestList: ModelList<BarterMateRequest>
    private var cancellables: Set<AnyCancellable> = []

    init(user: BarterMateUser) {
        self.user = user
        itemList = ModelList<BarterMateItem>.of(user.id)
        postingList = ModelList<BarterMatePosting>.of(user.id)
        requestList = ModelList<BarterMateRequest>.of(user.id)
        itemList.objectWillChange.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
        postingList.objectWillChange.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
        requestList.objectWillChange.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }

    func save(item: BarterMateItem) {
        itemList.insert(model: item)
        itemList.saveItem(element: item)
    }

    func delete(item: BarterMateItem) {
        itemList.delete(element: item)
        itemList.remove(model: item)
    }

}
