//
//  ChatListItemView.swift
//  BarterMate
//
//  Created by mark on 1/4/2023.
//

import Foundation
import SwiftUI

struct ChatListItemView: ListItemView, View {
    static func build(for item: BarterMateChat) -> ChatListItemView {
        print("built called")
        return ChatListItemView(item: item)
    }
    
    @ObservedObject var item: BarterMateChat
    @State var goToMessage = false
//    @ObservedObject var parentViewModel: ListViewModel<BarterMateChat>

    internal init(item: BarterMateChat) {
        self.item = item
        if(!item.hasFetchedDetails) {
            item.fetchDetails()
        }
//        self.parentViewModel = parentViewModel
    }
    
    var body: some View {
        Button(action: {
            Task {
                GlobalState.shared.currentChat = item
                goToMessage = true
            }
        }) {
            HStack {
                HStack {
                    Image(systemName: "person")
                        .frame(width: 150, height: 150)
                        .padding(.trailing, 10)
                    VStack(spacing: 5) {
                        HStack {
                            Text(item.name ?? "Default chat name")
                                .font(.callout)
                                .lineLimit(1)
                            Spacer()
                        }
                        HStack {
                            if((item.users) != nil){
                                ForEach(item.users!, id: \.id) { user in
                                    Text(user.username).font(.callout)
                                }
                            }
                            Spacer()
                        }
                        Button("Delete Item") {
                            //                        parentViewModel.deleteItem(item: chat)
                        }
                        
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
