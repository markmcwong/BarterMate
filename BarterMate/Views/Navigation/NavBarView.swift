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
            Spacer()
            TabBarButton(title: "Posting", imageSystemName: "plus.square.fill", isSelected: state == .posting) {
                state = .posting
            }
            Spacer()
            TabBarButton(title: "Request", imageSystemName: "list.bullet", isSelected: state == .request) {
                state = .request
            }
            Spacer()
            TabBarButton(title: "Profile", imageSystemName: "person.crop.circle.fill", isSelected: state == .profile) {
                state = .profile
            }
            Spacer()
            TabBarButton(title: "Transaction", imageSystemName: "arrow.up.arrow.down.square.fill", isSelected: state == .transaction) {
                state = .transaction
            }
            Spacer()
            TabBarButton(title: "Chat", imageSystemName: "message.fill", isSelected: state == .chat) {
                state = .chat
            }
            Spacer()
        }
        .frame(height: 60)
        .background(Color.white)
        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: -5)
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView(state: .constant(.profile))
    }
}

struct TabBarButton: View {
    let title: String
    let imageSystemName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageSystemName)
                    .font(.system(size: 24))
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(isSelected ? .blue : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}
