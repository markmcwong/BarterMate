//
//  BarterMateItem.swift
//  BarterMate
//
//  Created by Zico on 24/3/23.
//

import Foundation

class BarterMateItem: Hashable, ListElement, ObservableObject {
    private(set) var id: Identifier<BarterMateItem>
    private(set) var name: String
    private(set) var description: String
    var imageUrl: String?
    private(set) var ownerId: Identifier<BarterMateUser>
    private(set) var createdAt: Date
    private(set) var updatedAt: Date
    @Published var imageData: Data?

    private var itemFacade: (any ItemFacade)?

    static func getItemWithId(id: Identifier<BarterMateItem>) -> BarterMateItem {
        let item = createUnavailableItem()
        let facade = AmplifyItemFacade()
        item.itemFacade = facade
        facade.delegate = item
        item.itemFacade?.getItemById(id: id)
        return item
    }

    static func createUnavailableItem() -> BarterMateItem {
        BarterMateItem(id: Identifier(value: ""),
                       name: "",
                       description: "",
                       imageUrl: nil,
                       ownerId: Identifier(value: ""),
                       createdAt: .distantPast,
                       updatedAt: .distantPast)
    }

    init(id: Identifier<BarterMateItem> = Identifier(value: UUID().uuidString),
         name: String,
         description: String,
         imageUrl: String?,
         ownerId: Identifier<BarterMateUser>,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.ownerId = ownerId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        loadImage()
    }

    func loadImage() {
        guard let imageUrl = imageUrl else {
            return
        }
        ImageProvider(key: imageUrl).getImageFromKey { data in
            DispatchQueue.main.async {
                self.imageData = data
            }
        }
    }

    static func == (lhs: BarterMateItem, rhs: BarterMateItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension BarterMateItem: ItemFacadeDelegate {
    func update(item: BarterMateItem) {
        self.id = item.id
        self.name = item.name
        self.description = item.description
        self.imageUrl = item.imageUrl
        self.ownerId = item.ownerId
        self.createdAt = item.createdAt
        self.updatedAt = item.updatedAt
        loadImage()
    }
}
