//
//  NavBarView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

// TODO: Replace with styled Button

struct NavBarView: View {
    @Binding var state: AppState

    var body: some View {
        HStack {
            SwiftUI.Group {
                Spacer()
                Button("Posting") {
                    state = .posting
                }
            }

            Spacer()
            Button("Request") {
                state = .request
            }
            Spacer()
            Button("Profile") {
                state = .profile
            }
            Spacer()
            Button("Transaction") {
                state = .transaction
            }
            Spacer()
            Button("Chat") {
                state = .chat
            }
            Spacer()
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView(state: .constant(.profile))
    }
}
