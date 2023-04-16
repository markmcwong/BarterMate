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
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 16) {
                UserProfileImageView()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 1))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.username)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                }
                
                Spacer()
                
                if parentViewModel != nil {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            parentViewModel?.deleteItem(item: posting)
                        }
                }
            }
            
            Text(posting.item.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(posting.item.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            ItemImageView(item: posting.item)
                .scaledToFit()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView(posting: SamplePosting.bottlePosting, user: SampleUser.bill)
    }
}
