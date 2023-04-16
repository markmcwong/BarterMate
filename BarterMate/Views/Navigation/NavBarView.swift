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
            Button(action: { state = .posting }) {
                VStack {
                    Image(systemName: "plus.square.fill")
                        .font(.system(size: 24))
                    Text("Posting")
                        .font(.caption)
                }
                .foregroundColor(state == .posting ? .blue : .gray)
                .frame(maxWidth: .infinity)
            }
            Spacer()
            Button(action: { state = .request }) {
                VStack {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 24))
                    Text("Request")
                        .font(.caption)
                }
                .foregroundColor(state == .request ? .blue : .gray)
                .frame(maxWidth: .infinity)
            }
            Spacer()
            Button(action: { state = .profile }) {
                VStack {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 24))
                    Text("Profile")
                        .font(.caption)
                }
                .foregroundColor(state == .profile ? .blue : .gray)
                .frame(maxWidth: .infinity)
            }
            Spacer()
            Button(action: { state = .transaction }) {
                VStack {
                    Image(systemName: "arrow.up.arrow.down.square.fill")
                        .font(.system(size: 24))
                    Text("Transaction")
                        .font(.caption)
                }
                .foregroundColor(state == .transaction ? .blue : .gray)
                .frame(maxWidth: .infinity)
            }
            Spacer()
            Button(action: { state = .chat }) {
                VStack {
                    Image(systemName: "message.fill")
                        .font(.system(size: 24))
                    Text("Chat")
                        .font(.caption)
                }
                .foregroundColor(state == .chat ? .blue : .gray)
                .frame(maxWidth: .infinity)
            }
//            Spacer()
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

struct NavbarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white)
            .foregroundColor(Color.blue)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
