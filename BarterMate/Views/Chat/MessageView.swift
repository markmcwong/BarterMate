//
//  MessageView.swift
//  BarterMate
//
//  Created by mark on 2/4/2023.
//

import Foundation
import SwiftUI

struct MessageView: View {
    @State private var messageText = ""
//    let chat: BarterMateChat?
    let viewModel: MessageViewModel

    init(viewModel: MessageViewModel) {
//        guard let chat = chat else {
//            fatalError("Chat cannot be nil")
//        }
//        self.chat = chat
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            SubscribableListView<BarterMateMessage, MessageRow>(content: MessageRow.build, where: Message.self.keys.SentIn.eq(viewModel.chatId))
                .padding()
            // Message input field and send button
            HStack {
                TextField("Enter message...", text: $messageText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    viewModel.sendMessage(messageText)
                    messageText = ""
                }
            }
        }.navigationTitle(viewModel.chatName)
    }
}
    
//    private func loadMessages() {
//        // Load messages related to the chat using Amplify DataStore query
//        guard let messages = chat?.messages else {
//            return
//        }
//        // Sort messages by date in ascending order
//        self.messages = messages.sorted { $0.createdAt < $1.createdAt }
//    }
//    
////    @State private var messages: [BarterMateMessage] = []
//    
//    var body: some View {
////        if (chat == nil) {
////            Text("Something error - Chat not loaded")
////        }else {
//            
//        VStack {
//            LazyVStack {
//                ForEach(viewModel.modelList.elements, id: \.self) { message in
////                    if var user = viewModel.userIdToUser[message.sendBy] {
//                        MessageRow(message: message, isSentByMe: message.sentBy.id.value == GlobalState.shared.userId)
////                    }
//                }
//            }.id(UUID())
////            List(viewModel.modelList.elements) { message in
////                MessageRow(message: message, isSentByMe: message.sentBy.id.value == GlobalState.shared.userId)
////            }
////            .onAppear {
////                loadMessages()
////            }
//            
//            // Message input field and send button
//            HStack {
//                TextField("Enter message...", text: .constant(""))
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                Button("Send") {
//                    // Send message logic here
//                }
//            }
//            .padding()
//        }.navigationTitle("Default Chat Name")
////        }
//    }
//    
////    private func loadMessages() {
////        // Load messages related to the chat using Amplify DataStore query
////        guard let messages = chat?.messages else {
////            return
////        }
////        // Sort messages by date in ascending order
////        self.messages = messages.sorted { $0.createdAt < $1.createdAt }
////    }
//}

struct MessageRow: View, ListItemView {
    @ObservedObject var item: BarterMateMessage
    let isSentByMe: Bool
    
    static func build(for item: BarterMateMessage) -> MessageRow {
        print("built called")
        return MessageRow(item: item)
    }
    
    internal init(item: BarterMateMessage) {
        self.item = item
        if(!item.hasFetchedDetails) {
            item.fetchDetails()
        }
        self.isSentByMe = !(item.sentBy == nil) && (item.sentBy?.id.value == GlobalState.shared.userId)
    }
    
    var body: some View {
        HStack {
            if isSentByMe {
                Spacer()
                Text(item.content)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            } else {
                Text(item.content)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(10)
                if(item.sentBy != nil) {
                    Text("Sent by: " + item.sentBy!.username)
//                         + item.sentBy!.id.value)
                }
                Spacer()
            }
        }
    }
}

