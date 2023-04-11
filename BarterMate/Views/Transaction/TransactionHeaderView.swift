//
//  TransactionHeaderView.swift
//  BarterMate
//
//  Created by Zico on 9/4/23.
//

import SwiftUI

struct TransactionHeaderView: View {
    @ObservedObject var parentViewModel: TransactionViewModel
    let user: BarterMateUser
    
    var body: some View {
        HStack {
            Text(user.username)

            if parentViewModel.transaction.hasCompletedBarter.contains(user.id) {
                Text("Completed Trade")
            } else if parentViewModel.transaction.hasLockedOffer.contains(user.id) {
                Text("Item Locked")
            } else {
                Spacer()
            }
            
            if parentViewModel.user == user {
                if parentViewModel.transaction.hasLockedOffer.contains(user.id) {
                    Button("Complete Trade") {
                        parentViewModel.completeBarter()
                    }
                } else if parentViewModel.transaction.hasCompletedBarter.contains(user.id) {
                    Spacer()
                } else {
                    Button("Lock Trade") {
                        parentViewModel.lockItem()
                    }
                }
            }
        }
    }
}

struct TransactionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHeaderView(parentViewModel: TransactionViewModel(user: SampleUser.bill, transaction: SampleTransaction.sampleTransaction), user: SampleUser.bob)
    }
}


