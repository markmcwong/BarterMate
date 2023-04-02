//
//  ChatListItemView.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Foundation
import SwiftUI

struct ChatListItemView: View {

    let chat: BarterMateChat
//    @ObservedObject var parentViewModel: ListViewModel<BarterMateChat>

    init(chat: BarterMateChat) {
        self.chat = chat
//        self.parentViewModel = parentViewModel
    }
    
    var body: some View {
        Button(action: {
            Task {
                await chat.fetchMessages {}
                GlobalState.shared.currentChat = chat
                Router.singleton.navigate(to: .message)
            }
        }) {
            HStack {
                HStack {
                    Image(systemName: "person")
                        .frame(width: 150, height: 150)
                        .padding(.trailing, 10)
                    VStack(spacing: 5) {
                        HStack {
                            Text(chat.name ?? "Default chat name")
                                .font(.callout)
                                .lineLimit(1)
                            Spacer()
                        }
                        HStack {
                            ForEach(chat.users, id: \.id) { user in
                                Text(user.username).font(.callout)
                            }
                            Spacer()
                        }
                        Button("Delete Item") {
                            //                        parentViewModel.deleteItem(item: chat)
                        }
                    }
                }
                .padding()
                .background(Rectangle().fill(Color.white))
                .border(.green)
                .shadow(color: .gray, radius: 3, x: 2, y: 2)
            }
        }
    }
}

//struct ChatListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//    }
//}
