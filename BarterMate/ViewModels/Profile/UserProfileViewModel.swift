import Foundation
import Combine

class UserProfileViewModel: ObservableObject {

    @Published var user: BarterMateUser
    @Published var itemList: ModelList<BarterMateItem>
    @Published var postingList: ModelList<BarterMatePosting>
    @Published var requestList: ModelList<BarterMateRequest>
    private var cancellables: Set<AnyCancellable> = []

    init(user: BarterMateUser) {
        self.user = user
        itemList = ModelList<BarterMateItem>.of(user.id)
        postingList = ModelList<BarterMatePosting>.of(user.id)
        requestList = ModelList<BarterMateRequest>.of(user.id)
        itemList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
        postingList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
        requestList.objectWillChange.receive(on: DispatchQueue.main).sink {
            [weak self] _ in
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
    
//    func makePosting(item: BarterMateItem) {
//        BarterMatePosting(id: <#T##Identifier<BarterMatePosting>#>,
//                          item: <#T##BarterMateItem#>,
//                          createdAt: <#T##Date#>,
//                          updatedAt: <#T##Date#>)
//    }
}
