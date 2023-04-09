//
//  SubscribableListView.swift
//  BarterMate
//
//  Created by mark on 7/4/2023.
//

import Foundation
import SwiftUI

struct SubscribableListView<U: ListElement, Content: ListItemView<U>> : View {
    typealias T = any ListItemView<U>
    @ObservedObject var viewModel: SubscribableListViewModel<U>
    let content: (U) -> Content
    
    init(content: @escaping (U) -> Content) {
        self.viewModel = SubscribableListViewModel<U>()
        self.content = content
    }
    
    var body: some View {
        Text("SubscribableListView " + viewModel.items.description)
        LazyVStack {
            ForEach(viewModel.items, id: \.self) { item in
                Content.build(for: item)
                Text(item.typeName)
            }
        }.id(UUID())
        .onAppear {
            viewModel.subscribeToUpdates()
        }
        .onDisappear {
            viewModel.unsubscribeFromUpdates()
        }
    }
}
