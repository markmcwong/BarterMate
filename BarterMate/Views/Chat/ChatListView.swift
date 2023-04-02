//
//  ChatListView.swift
//  BarterMate
//
//  Created by mark on 20/3/2023.
//

import Foundation
import SwiftUI

struct ChatListView: View {
//    @ObservedObject var viewModel: ListViewModel<BarterMateChat> = ListViewModel(user: SampleUser.bill, modelList: ModelList<BarterMateChat>.all())

    @ObservedObject var viewModel = ChatListViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                VStack {
                    ForEach(viewModel.chatList.elements, id: \.self) { chat in
                        ChatListItemView(chat: chat)
                    }
                }.id(UUID())
                
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
