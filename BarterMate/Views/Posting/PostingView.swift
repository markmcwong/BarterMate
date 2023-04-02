//
//  PostingView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct PostingView: View {

    let posting: BarterMatePosting
    let user: BarterMateUser
    
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

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView(posting: SamplePosting.bottlePosting, user: SampleUser.bill)
    }
}

