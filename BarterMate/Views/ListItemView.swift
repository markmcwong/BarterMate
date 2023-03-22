//
//  ListItemView.swift
//  BarterMate
//
//  Created by mark on 22/3/2023.
//

import Foundation
import SwiftUI

protocol GenericListItemView : View {
    associatedtype ListItemType: BarterMateModel
    //    associatedtype V: View   // Create a new type that conforms to View
    //    static func createFrom(_ genericItem: ListItemType) -> V

    //    init(viewModel: any GenericListItemViewModel)
    init(item: ListItemType)
}

//struct ListItemView<T: BarterMateModel, U: GenericListItemViewModel>: View, GenericListItemView where U.ListItemType == T {
////    typealias ListItemType = T
////    init(viewModel: any GenericListItemViewModel) {
////        self._viewModel = StateObject(wrappedValue: viewModel)
////    }
//
//    init(item: T) {
//        self._viewModel = StateObject(wrappedValue: U(item: item))
//    }
//
//    @StateObject var viewModel: U
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                UserProfileImageView()
//                    .frame(width: 40,  height: 40)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(lineWidth: 1))
//                VStack(alignment: .leading) {
//                        Text("Bob")
//                            .font(.system(size: 20))
//                            .bold()
//                }
//                Spacer()
//                Image(systemName: "ellipsis")
//            }
//            Text("Water Bottle 500 ml")
//            ZStack {
//                Image(systemName: "plus.square.fill")
//                    .resizable()
//                    .scaledToFit()
//            }
//        }
//        .padding()
//    }
//}
