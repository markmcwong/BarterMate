//
//  MessageRow.swift
//  BarterMate
//
//  Created by mark on 16/4/2023.
//

import Foundation
import SwiftUI

struct MessageRow: View, ListItemView {
    var model: ListViewModel<BarterMateMessage>?
    @ObservedObject var item: BarterMateMessage
    let isSentByMe: Bool
    
    static func build(for item: BarterMateMessage, model: ListViewModel<BarterMateMessage>? = nil) -> MessageRow {
        MessageRow(item: item, model: model)
    }
    
    internal init(item: BarterMateMessage, model: ListViewModel<BarterMateMessage>? = nil) {
        self.item = item
        self.model = model
        if !item.hasFetchedDetails {
            item.fetchDetails()
        }
        self.isSentByMe = !(item.sentBy == nil) && (item.sentBy?.id.value == GlobalState.shared.userId)
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            if isSentByMe {
                Spacer()
                Text(item.content)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20, corners: [.topLeft, .bottomLeft, .bottomRight])
                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.content)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                    if item.sentBy != nil {
                        Text("Sent by: " + item.sentBy!.username)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
