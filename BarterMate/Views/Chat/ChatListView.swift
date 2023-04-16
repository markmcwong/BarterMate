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
        ZStack {
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
                    }
                    
                    Button {
                        viewModel.refresh()
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                    }
                }
            }.onAppear(perform: { viewModel.fetchChatUserBelongsTo() }).refreshable {
                viewModel.refresh()
            }
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        addChat = true
                    }) {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
        }.sheet(isPresented: $addChat) {
            UserSelectionView(user: GlobalState.shared.user!, chatList: viewModel.modelList, addChat: $addChat)
        }
//        NavigationLink(
//            "",
//            destination: LazyView {
//                UserSelectionView(user: GlobalState.shared.user!, chatList: viewModel.modelList, addChat: $addChat)
//            },
//            isActive: $addChat
//        )
//        .hidden()
    }
}

// struct ChatListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListView()
//    }
// }
