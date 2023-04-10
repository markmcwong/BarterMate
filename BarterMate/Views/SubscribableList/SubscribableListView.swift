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
    typealias T = any ListItemView<U>
    @ObservedObject var viewModel: SubscribableListViewModel<U>
    let content: (U) -> Content
    
    init(content: @escaping (U) -> Content) {
        self.viewModel = SubscribableListViewModel<U>()
        self.content = content
    }
    
    init(content: @escaping (U) -> Content, where predicate: QueryPredicate) {
        self.viewModel = SubscribableListViewModel<U>(where: predicate)
        self.content = content
    }
    
    var body: some View {
        LazyVStack {
            ForEach(viewModel.items, id: \.self.id) { item in
                Content.build(for: item)
            }
        }.id(UUID())
//        .onAppear {
//            viewModel.subscribeToUpdates()
//        }
//        .onDisappear {
//            viewModel.unsubscribeFromUpdates()
//        }
    }
}
