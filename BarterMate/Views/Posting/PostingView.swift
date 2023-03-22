//
//  PostingView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct PostingView: View, GenericListItemView {
    typealias ListItemType = Posting
    
//    init(viewModel: any GenericListItemViewModel) {
//        self._viewModel = StateObject(wrappedValue: viewModel as! PostingViewModel)
//
    
    init(item: Posting) {
        self._viewModel = ObservedObject(wrappedValue: ListItemViewModel(item: item))
    }
    
    @ObservedObject var viewModel: ListItemViewModel<Posting>

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                UserProfileImageView()
                    .frame(width: 40,  height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 1))
                VStack(alignment: .leading) {
                        Text("Bob")
                            .font(.system(size: 20))
                            .bold()
                }
                Spacer()
                Image(systemName: "ellipsis")
            }
            Text("Water Bottle 500 ml")
            ZStack {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .scaledToFit()
            }
        }
        .padding()
    }

//    static func createFrom(_ genericItem: Posting) -> any V {
//        return PostingView(viewModel: genericItem)
//    }
                             
}
//
//struct PostingView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostingView(item: Posting(userID: "abc",item: Item(description: "Random item",userID: "abc")))
//    }
//}

