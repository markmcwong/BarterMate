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
            HStack {
                UserProfileImageView()
                    .frame(width: 50, height: 50)
                    .background(Circle().fill(Color.gray))
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                VStack(spacing: 5) {
                    HStack {
                        Text(user.username)
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()

                    }
                    HStack {
                        Text(request.description)
                            .font(.callout)
                            .lineLimit(1)
                        Spacer()

                    }
                }
                if parentViewModel != nil {
                    Image(systemName: "xmark")
                        .frame(width: 25, height: 25)
                        .background(Circle().fill(Color.gray))
                        .padding(.leading, 10)
                        .onTapGesture {
                            parentViewModel?.deleteItem(item: request)
                        }
                }

            }
            .padding()
            .background(Rectangle().fill(Color.white))
            .cornerRadius(10)
            .shadow(color: .gray, radius: 3, x: 2, y: 2)
        }
    }
}

//struct RequestCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestCardView(request: Request(id: "a", description: "Hello World", createdAt: nil, owner: User())
//    }
//}

