//
//  ItemListView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct ItemListView: View {
    
    @StateObject var viewModel = UserProfileViewModel()
    
    var body: some View {
        VStack {
            LazyVStack {
               ForEach(viewModel.loadedItems.indices, id: \.self) { index in
                   ItemCardView(item: viewModel.loadedItems[index])               }
            }.id(UUID())
            
           if viewModel.loadedItems.count == 0 {
               Text("No More Item")
                   .padding()
            } else {

            }
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
