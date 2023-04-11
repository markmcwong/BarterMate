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

            if parentViewModel.transaction.hasLockedOffer.contains(user) {
                Text("Item Locked")
            } else if parentViewModel.transaction.hasCompletedBarter.contains(user) {
                Text("Completed Trade")
            } else {
                Spacer()
            }
            
            if parentViewModel.user == user {
                if parentViewModel.transaction.hasLockedOffer.contains(user) {
                    Button("Complete Trade") {
                        print("Completed")
                    }
                } else if parentViewModel.transaction.hasCompletedBarter.contains(user) {
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

