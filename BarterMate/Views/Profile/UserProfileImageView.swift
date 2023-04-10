//
//  UserProfileImageView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct UserProfileImageView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFill()
                .background(Color(.lightGray))
        }
    }
}

struct UserProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileImageView()
    }
}


