//
//  SubscribableListView.swift
//  BarterMate
//
//  Created by mark on 7/4/2023.
//

import Foundation
import SwiftUI
import Amplify

struct SubscribableListView<U: ListElement, Content: ListItemView<U>> : View {
    @ObservedObject var viewModel: SubscribableListViewModel<U>
    let content: (U, ListViewModel<U>) -> Content
    
    init(content: @escaping (U, ListViewModel<U>) -> Content) {
        self.viewModel = SubscribableListViewModel<U>()
        self.content = content
    }
    
    init(content: @escaping (U, ListViewModel<U>) -> Content, where predicate: QueryPredicate) {
        self.viewModel = SubscribableListViewModel<U>(where: predicate)
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.items, id: \.self.id) { item in
                Content.build(for: item, model: nil)
            }
        }.id(UUID())
       .onDisappear {
           viewModel.unsubscribeFromUpdates()
       }
    }
}
