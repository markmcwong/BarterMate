//
//  PostingView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct PostingView: View {

    @ObservedObject var posting: BarterMatePosting
    let user: BarterMateUser
    var parentViewModel: ListViewModel<BarterMatePosting>?
    
    init(posting: BarterMatePosting, user: BarterMateUser, parentViewModel: ListViewModel<BarterMatePosting>) {
        self.posting = posting
        self.user = user
        self.parentViewModel = parentViewModel
    }
    
    init(posting: BarterMatePosting, user: BarterMateUser) {
        self.posting = posting
        self.user = user
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                UserProfileImageView()
                    .frame(width: 40,  height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 1))
                VStack(alignment: .leading) {
                    Text(user.username)
                            .font(.system(size: 20))
                            .bold()
                }
                Spacer()
                if parentViewModel != nil {
                    Image(systemName: "x.circle.fill")
                        .onTapGesture {
                            parentViewModel?.deleteItem(item: posting)
                        }
                }
            }

                Text(posting.item.name)
                Text(posting.item.description)
            

            ZStack {
                ItemImageView(item: posting.item)
                    .scaledToFit()
            }
        }
        .padding()
    }
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView(posting: SamplePosting.bottlePosting, user: SampleUser.bill)
    }
}


