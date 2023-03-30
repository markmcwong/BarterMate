//
//  MyItemCard.swift
//  BarterMate
//
//  Created by Zico on 28/3/23.
//

import Foundation
import SwiftUI

struct MyItemCardView: View {

    @ObservedObject var viewModel: ItemViewModel
    @ObservedObject var parentViewModel: UserProfileViewModel

    init(item: BarterMateItem, parentViewModel: UserProfileViewModel) {
        _viewModel = ObservedObject(wrappedValue: ItemViewModel(item: item))
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
                        Text(viewModel.item.name )
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()
                    }
                    HStack {
                        Text(viewModel.item.description )
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()
                    }
                    Button("Make posting") {
                        print("clicked")
                    }
                    Button("Delete Item") {
                        parentViewModel.delete(item: viewModel.item)
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
        let viewModel = { () -> UserProfileViewModel in
            let viewModel = UserProfileViewModel(user: SampleUser.bill)
            viewModel.itemList.elements = [SampleItem.guitar, SampleItem.waterBottle]
            return viewModel
        }()
        
        VStack {
            MyItemCardView(item: SampleItem.waterBottle, parentViewModel: viewModel)
            MyItemCardView(item: SampleItem.guitar, parentViewModel: viewModel)
        }

    }
}
