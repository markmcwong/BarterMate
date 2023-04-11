//
//  TransactionPreview.swift
//  BarterMate
//
//  Created by Zico on 8/4/23.
//

import SwiftUI

struct TransactionCardView: View {

    @ObservedObject var viewModel: TransactionViewModel
    @State var goToTransaction: Bool = false
    
    init(user: BarterMateUser, transaction: BarterMateTransaction) {
        print(user.username)
        self.viewModel = TransactionViewModel(user: user, transaction: transaction)
    }
    
    var body: some View {
        HStack {
            ForEach(Array(viewModel.transaction.participants), id: \.self) { participant in
                HStack {
                    UserProfileImageView()
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.gray))
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                        HStack {
                            Text(participant.username)
                                .font(.callout)
                                .lineLimit(1)
                            Spacer()

                        }
                    
                    NavigationLink(
                        "",
                        destination: LazyView {
                            TransactionView(user: viewModel.user, transaction: viewModel.transaction)
                        },
                        isActive: $goToTransaction
                    )
                    .hidden()
                }.onTapGesture {
                    goToTransaction = true
                }
            
            }
        }
        .padding()
        .background(Rectangle().fill(Color.white))
        .cornerRadius(10)
        .shadow(color: .gray, radius: 3, x: 2, y: 2)
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCardView(user: SampleUser.bill, transaction: SampleTransaction.sampleTransaction)
    }
}

