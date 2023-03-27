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

    init(item: BarterMateItem) {
        _viewModel = ObservedObject(wrappedValue: ItemViewModel(item: item))
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

struct MyItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MyItemCardView(item: SampleItem.waterBottle)
            MyItemCardView(item: SampleItem.guitar)
        }

    }
}
