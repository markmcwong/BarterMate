//
//  ItemCardView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct ItemCardView: View {
    @StateObject var viewModel: ItemViewModel

    init(item: Item) {
        _viewModel = StateObject(wrappedValue: ItemViewModel(item: item))
    }
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "person")
                    .frame(width: 150, height: 150)
                    .padding(.trailing, 10)
                VStack(spacing: 5) {
//                    HStack {
//                        Text(viewModel.ownerName ?? "loading name")
//                            .font(.callout)
//                            .lineLimit(1)
//                        Spacer()
//
//                    }
                    HStack {
                        Text(viewModel.item.name ?? "name")
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()
                    }
                    HStack {
                        Text(viewModel.item.description ?? "description")
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()
                    }
                    Button(action: {}) {
                        Text("Make Posting")
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

struct ItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ItemCardView(item: Item(userID: "test"))
            ItemCardView(item: Item(userID: "test2"))
        }

    }
}
