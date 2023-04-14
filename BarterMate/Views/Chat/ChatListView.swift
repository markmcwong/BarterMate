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
    @State private var addChat = false

    var body: some View {
        ScrollView(.vertical) {
            VStack {
//                SubscribableListView<BarterMateUserChat, ChatListItemView>(content: ChatListItemView.build, where: UserChat.keys.user.eq( GlobalState.shared.userId))
                VStack {
                    ForEach(viewModel.modelList.elements, id: \.self.id) { chat in
                        ChatListItemView(item: chat
                                         , model: viewModel)
                    }
                }.id(UUID())
//
                if viewModel.modelList.elements.count == 0 {
                   Text("No More Item")
                       .padding()
                } else {

                }
            }
        }.navigationTitle("Total number of Chats: " + viewModel.modelList.elements.count.description)
            .onAppear(perform: {viewModel.fetchChatUserBelongsTo()})
        ProfileButtonsView().onTapGesture {
            addChat = true
        }
        NavigationLink(
            "",
            destination: LazyView {
                UserSelectionView(user: GlobalState.shared.user!, chatList: viewModel, addChat: $addChat)
            },
            isActive: $addChat
        )
        .hidden()
    }
}

//struct ChatListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListView()
//    }
//}
