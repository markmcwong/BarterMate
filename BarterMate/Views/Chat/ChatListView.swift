//
//  ChatListView.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Foundation
import SwiftUI

struct ChatListView: View {
    @ObservedObject var viewModel = ChatListViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                SubscribableListView<BarterMateChat, ChatListItemView>(content: ChatListItemView.build)
//                VStack {
//                    ForEach(viewModel.chatList.elements, id: \.self) { chat in
//                        ChatListItemView(item: chat)
//                    }
//                }.id(UUID())
                Text(viewModel.chatList.elements.count.description)
                if viewModel.chatList.elements.count == 0 {
                   Text("No More Item")
                       .padding()
                } else {

                }
            }
        }
    }
}

//struct ChatListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListView()
//    }
//}
