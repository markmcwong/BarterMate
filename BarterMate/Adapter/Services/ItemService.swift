//
//  ItemService.swift
//  BarterMate
//
//  Created by Zico on 19/3/23.
//

protocol ItemService: DataStoreService {
    func saveItem(_ item: Item) async throws -> Item
    func deleteItem(_ item: Item) async throws
}
