//
//  MyItemCard.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import Foundation
import SwiftUI

struct MyItemCardView: View {

    let item: BarterMateItem
    @ObservedObject var parentViewModel: ListViewModel<BarterMateItem>

    init(item: BarterMateItem, parentViewModel: ListViewModel<BarterMateItem>) {
        self.item = item
        self.parentViewModel = parentViewModel
    }
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "person")
                    .frame(width: 150, height: 150)
                    .padding(.trailing, 10)
                VStack(spacing: 5) {
                    HStack {
                        Text(item.name )
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()
                    }
                    HStack {
                        Text(item.description)
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()
                    }
                    Button("Delete Item") {
                        parentViewModel.deleteItem(item: item)
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

struct MyItemCardView_Previews: PreviewProvider {
    static var previews: some View {
//        let viewModel = { () -> ItemListViewModel in
//            let viewModel = ItemListViewModel(user: SampleUser.bill, itemList: ModelList<BarterMateItem>.of(SampleUser.bill.id))
//            return viewModel
//        }()
        
        let viewModel = ListViewModel(user: SampleUser.bill, modelList: ModelList<BarterMateItem>.of(SampleUser.bill.id))
        
        VStack {
            MyItemCardView(item: SampleItem.waterBottle, parentViewModel: viewModel)
            MyItemCardView(item: SampleItem.guitar, parentViewModel: viewModel)
        }

    }
}
