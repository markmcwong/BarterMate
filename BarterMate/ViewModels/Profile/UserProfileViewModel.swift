import Foundation
import Combine

class UserProfileViewModel: ObservableObject {

    let user: BarterMateUser
    @Published var itemList: ModelList<BarterMateItem>
    private var cancellables: Set<AnyCancellable> = []
    
    @MainActor
    init(user: BarterMateUser) {
        self.user = user
        itemList = ModelList<BarterMateItem>.of(user.id)
        itemList.objectWillChange.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &cancellables)
    }
    
    func delete(item: BarterMateItem) {

    }
}
