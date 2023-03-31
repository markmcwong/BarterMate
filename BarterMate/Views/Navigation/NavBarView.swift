//
//  NavBarView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

//TODO: Replace with styled Button

struct NavBarView: View {
    var body: some View {
        HStack {
            SwiftUI.Group {
                Spacer()
                Button("Posting") {
                    print("Click Chat")
                }
            }

            Spacer()
            Button("Request") {
                print("Click Chat")
            }
            Spacer()
            Button("Profile") {
                print("Click Chat")
            }
            Spacer()
            Button("Transaction") {
                print("Click Chat")
            }
            Spacer()
            Button("Chat") {
                print("Click Chat")
            }
            Spacer()
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
    }
}
