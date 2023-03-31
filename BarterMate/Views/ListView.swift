//
//  ListView.swift
//  BarterMate
//
//  Created by mark on 22/3/2023.
//
//
//import Foundation
//import SwiftUI
//
//struct ListView<T: BarterMateModel, ItemView: GenericListItemView> : View where ItemView.ListItemType == T {
//    @StateObject var viewModel = ListViewModel(service: AmplifyGenericModelService<T>())
//    
//    var body: some View {
//        ScrollView(.vertical) {
//            VStack {
//                LazyVStack {
//                    ForEach(viewModel.loadedObjects.indices, id: \.self) { index in
//                        ItemView(item: viewModel.loadedObjects[index] as T)
//                    }
//                }.id(UUID())
//                
//                if viewModel.loadedObjects.count == 0 {
//                    Text("No More " + String(describing: T.self))
//                        .padding()
//                } else {
//                    
//                }
//            }
//
//        }
//    }
//}
