//
//  MessageView.swift
//  BarterMate
//
//  Created by mark on 2/4/2023.
//

import Foundation
import SwiftUI

struct MessageView: View {
    @ObservedObject var viewModel: MessageViewModel

    init(viewModel: MessageViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Spacer()
            SubscribableListView<BarterMateMessage, MessageRow>(content: MessageRow.build
                                                                , where: Message.keys.sentInID.eq(viewModel.chatId)).padding(5)
            MessageInputView(viewModel: viewModel)
        }.navigationTitle(viewModel.chatName + "\n" + viewModel.chatId)
    }
}

struct MessageInputView: View {
    @State private var messageText = ""
    let viewModel: MessageViewModel

    init(viewModel: MessageViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            TextField("Enter message...", text: $messageText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Send") {
                viewModel.sendMessage(messageText)
                messageText = ""
            }
        }
        .padding()
    }
}
