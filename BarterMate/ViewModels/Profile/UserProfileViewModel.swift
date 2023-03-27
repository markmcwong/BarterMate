import Foundation


class UserProfileViewModel: ObservableObject {

    let user: BarterMateUser
    let itemList: ItemList
    
    init(user: BarterMateUser) {
        self.user = user
        itemList = ItemList.of(user.id)
    }
}
