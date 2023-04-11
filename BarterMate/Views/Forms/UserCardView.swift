//
//  UserCardView.swift
//  BarterMate
//
//  Created by Zico on 12/4/23.
//

import SwiftUI

struct UserCardView: View {

    @ObservedObject var item: BarterMateUser
    
    var body: some View {
        HStack {
            UserProfileImageView()
                .frame(width: 50, height: 50)
                .background(Circle().fill(Color.gray))
                .clipShape(Circle())
                .padding(.trailing, 10)
            HStack {
                Text(item.username)
                    .font(.callout)
                    .lineLimit(1)
                Spacer()
                
            }
        }
    }
}

//struct UserCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCardView()
//    }
//}

