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
        HStack(spacing: 4) {
            UserProfileImageView()
                .frame(width: 30, height: 30)
                .background(Circle().fill(Color.gray))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.username)
                    .font(.headline)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}


// struct UserCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCardView()
//    }
// }
