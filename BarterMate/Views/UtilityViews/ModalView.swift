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
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(.white)
                                .frame(width: min(geometry.size.width + 100, 300), height: min(geometry.size.height + 100, 300))
                                .overlay(alignment: .top) {
                                    ModalContentView(displayView: {self.displayView}, showModal: self.$showModal)
                                }
                        }
                )
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
            Text("Modal Content")

            Button(action: {
                self.showModal.toggle()
            }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                    Text("Close Modal")
                }
            }
        }
    }
}


struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(displayView: {EmptyView()}, showModal: .constant(true))
    }
}
