//
//  MessageView.swift
//  BarterMate
//
//  Created by mark on 2/4/2023.
//

import Foundation
import SwiftUI

struct MessageView: View {
    @ObservedObject var viewModel: BaseViewModel<BarterMateMessage>
    let chat: BarterMateChat
    
    init(viewModel: BaseViewModel<BarterMateMessage>, chat: BarterMateChat) {
        self.viewModel = MessageListViewModel(modelType: BarterMateMessage.self, modelId: chat.id)
        self.chat = chat
    }
    
//    @State private var messages: [BarterMateMessage] = []
    
    var body: some View {
//        if (chat == nil) {
//            Text("Something error - Chat not loaded")
//        }else {
            
        VStack {
            LazyVStack {
                ForEach(viewModel.modelList.elements, id: \.self) { message in
//                    if var user = viewModel.userIdToUser[message.sendBy] {
                        MessageRow(message: message, isSentByMe: message.sentBy.id.value == GlobalState.shared.userId)
//                    }
                }
            }.id(UUID())
//            List(viewModel.modelList.elements) { message in
//                MessageRow(message: message, isSentByMe: message.sentBy.id.value == GlobalState.shared.userId)
//            }
//            .onAppear {
//                loadMessages()
//            }
            
            // Message input field and send button
            HStack {
                TextField("Enter message...", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    // Send message logic here
                }
            }
            .padding()
        }.navigationTitle("Default Chat Name")
//        }
    }
    
//    private func loadMessages() {
//        // Load messages related to the chat using Amplify DataStore query
//        guard let messages = chat?.messages else {
//            return
//        }
//        // Sort messages by date in ascending order
//        self.messages = messages.sorted { $0.createdAt < $1.createdAt }
//    }
}

struct MessageRow: View {
    let message: BarterMateMessage
    let isSentByMe: Bool
    
    var body: some View {
        HStack {
            if isSentByMe {
                Spacer()
                Text(message.content)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            } else {
                Text(message.content)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(10)
                Spacer()
            }
        }
    }
}

