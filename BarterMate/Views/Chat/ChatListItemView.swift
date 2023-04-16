//
//  ChatListItemView.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Foundation
import SwiftUI

struct ChatListItemView: ListItemView, View {
    var model: ListViewModel<BarterMateChat>?
    @ObservedObject var item: BarterMateChat

    static func build(for item: BarterMateChat, model: ListViewModel<BarterMateChat>?) -> ChatListItemView {
        ChatListItemView(item: item, model: model)
    }
    @State var goToMessage = false
//    @ObservedObject var parentViewModel: ListViewModel<BarterMateChat>

    internal init(item: BarterMateChat, model: ListViewModel<BarterMateChat>?) {
        self.item = item
        self.model = model
        if !item.hasFetchedDetails {
            item.fetchDetails()
        }
    }
    
    var body: some View {
        Button(action: {
            GlobalState.shared.currentChat = item
            goToMessage = true
        }) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.name ?? "Default chat name")
                            .font(.headline)
                            .foregroundColor(.primary)
                        HStack(spacing: 10) {
                            if let users = item.users {
                                ForEach(users, id: \.id) { user in
                                    Text(user.username)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .padding(5)
                                        .background(Color.green.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        if model != nil {
                            model!.deleteItem(item: item)
                        } else {
                            print("model does not exist for deleting item")
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
//                            .padding(10)
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
//                            .shadow(color: .gray, radius: 3, x: 2, y: 2)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 3, x: 2, y: 2)
            }
            .padding(.horizontal)
        }
        .padding(5)
        .background(Color.clear)
        NavigationLink(
           "",
           destination: LazyView {
               MessageView(viewModel: MessageViewModel(chat: GlobalState.shared.currentChat))
           },
           isActive: $goToMessage
         )
       .hidden()
    }
}

// struct ChatListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//    }
// }
