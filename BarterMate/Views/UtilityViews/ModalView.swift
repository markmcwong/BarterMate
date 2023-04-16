//
//  ModalView.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import SwiftUI

struct ModalView<DisplayView: View>: View {
    @Binding var showModal: Bool

    let displayView: DisplayView

    init(@ViewBuilder displayView: () -> DisplayView, showModal: Binding<Bool>) {
        self.displayView = displayView()
        self._showModal = showModal
    }

    var body: some View {
        SwiftUI.Group {
            if showModal {
                VStack {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            GeometryReader { proxy in
                                VStack {
                                    Color.clear.overlay(                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundColor(.white)
                                        .frame(width: proxy.size.width * 0.8,
                                               height: proxy.size.height * 0.8,
                                               alignment: .center)
                                        .overlay(alignment: .center) {
                                            ModalContentView(displayView: { self.displayView },
                                                             showModal: self.$showModal).frame(width: proxy.size.width * 0.7,
                                                                                               height: proxy.size.height * 0.7)
                                        }
                                    )
                                }
                            }
                        )
                }
            }
        }
    }
}

struct ModalContentView<DisplayView: View>: View { // the real modal content
    @Binding var showModal: Bool

    let displayView: DisplayView

    init(@ViewBuilder displayView: () -> DisplayView, showModal: Binding<Bool>) {
        self.displayView = displayView()
        self._showModal = showModal
    }

    var body: some View {
        VStack {
            self.displayView

            Spacer()
            Button(action: {
                self.showModal.toggle()
            }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                    Text("Go back")
                }
            }
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(displayView: { EmptyView() }, showModal: .constant(true))
    }
}
