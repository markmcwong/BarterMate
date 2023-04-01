//
//  NavBarView.swift
//  BarterMate
//
//  Created by Zico on 1/4/23.
//

import SwiftUI

//TODO: Replace with styled Button

struct NavBarView: View {
    @StateObject private var router = Router.singleton
    
    var body: some View {
        HStack {
            SwiftUI.Group {
                Spacer()
                Button("Posting") {
                    router.navigate(to: .posting)
                }
            }

            Spacer()
            Button("Request") {
                router.navigate(to: .request)
            }
            Spacer()
            Button("Profile") {
                router.navigate(to: .profile)
            }
            Spacer()
            Button("Transaction") {
                print("Click Chat")
            }
            Spacer()
            Button("Chat") {
                print("Click Chat")
                router.navigate(to: .chat)
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
