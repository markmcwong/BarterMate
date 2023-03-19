//
//  PostingView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct PostingView: View {
    
    @StateObject var viewModel: PostingViewModel

    init(posting: Posting) {
        self._viewModel = StateObject(wrappedValue: PostingViewModel(posting: posting))
    }
    
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

                             
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView(posting: Posting(userID: "abc",item: Item(description: "Random item",userID: "abc")))
    }
}

