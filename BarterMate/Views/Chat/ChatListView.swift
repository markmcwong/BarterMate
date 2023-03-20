//
//  ChatListView.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Foundation

struct ChatListView: View {
    @StateObject var viewModel = ChatListViewModel()

    var body: some View {
        VStack {
            if viewModel.loading {
                ProgressView()
            } else if viewModel.chats.isEmpty {
                Text("No chats")
            } else {
                List(viewModel.chats) { chat in
                    NavigationLink(destination: ChatView(chat: chat)) {
                        Text(chat.name ?? "Unnamed chat")
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitle("Chats")
        .onAppear(perform: viewModel.loadChats)
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
