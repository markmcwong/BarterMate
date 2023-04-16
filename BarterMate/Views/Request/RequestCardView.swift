//
//  RequestCardView.swift
//  BarterMate
//
//  Created by Zico on 17/3/23.
//

import SwiftUI

struct RequestCardView: View {
    let request: BarterMateRequest
    let user: BarterMateUser
    var parentViewModel: ListViewModel<BarterMateRequest>?

    init(request: BarterMateRequest, user: BarterMateUser) {
        self.request = request
        self.user = user
    }

    init(request: BarterMateRequest, user: BarterMateUser, parentViewModel: ListViewModel<BarterMateRequest>) {
        self.request = request
        self.user = user
        self.parentViewModel = parentViewModel
    }

    var body: some View {
        HStack {
           UserProfileImageView()
               .frame(width: 50, height: 50)
               .background(Color.gray)
               .clipShape(Circle())
               .padding(.trailing, 10)
           
           VStack(alignment: .leading, spacing: 5) {
               Text(user.username)
                   .font(.title3)
                   .fontWeight(.semibold)
               
               Text(request.description)
                   .font(.body)
                   .lineLimit(2)
                   .foregroundColor(.secondary)
               
           }
           
           if parentViewModel != nil {
               Image(systemName: "xmark.circle.fill")
                   .resizable()
                   .frame(width: 25, height: 25)
                   .foregroundColor(.gray)
                   .onTapGesture {
                       parentViewModel?.deleteItem(item: request)
                   }
           }
           
           Spacer()
       }
       .padding(10)
       .background(Color.white)
       .cornerRadius(10)
       .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

// struct RequestCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestCardView(request: Request(id: "a", description: "Hello World", createdAt: nil, owner: User())
//    }
// }
