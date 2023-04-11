//
//  MyPostingView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

struct MyPostingView: View {

    let posting: BarterMatePosting
    @ObservedObject var parentViewModel: ListViewModel<BarterMatePosting>
    
    init(posting: BarterMatePosting, parentViewModel: ListViewModel<BarterMatePosting>) {
        self.posting = posting
        self.parentViewModel = parentViewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                UserProfileImageView()
                    .frame(width: 40,  height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 1))
                VStack(alignment: .leading) {
                    Text(parentViewModel.user!.username)
                            .font(.system(size: 20))
                            .bold()
                }
                Spacer()
                Image(systemName: "ellipsis")
            }
            Text(posting.item.description)
            ZStack {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .scaledToFit()
            }
        }
        .padding()
    }
}

struct MyPostingView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostingView(posting: SamplePosting.bottlePosting, parentViewModel: ListViewModel(user: SampleUser.bill, modelList: ModelList.of(SampleUser.bill.id)))
    }
}
