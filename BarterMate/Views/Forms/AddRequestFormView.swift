//
//  AddRequestFormVIew.swift
//  BarterMate
//
//  Created by Zico on 6/4/23.
//

import SwiftUI

struct AddRequestFormView: View {
    @ObservedObject var viewModel: AddRequestViewModel
    @Binding var showModal: Bool

    init(ownerId: Identifier<BarterMateUser>, requestList: ModelList<BarterMateRequest>, showModal: Binding<Bool>) {
        self.viewModel = AddRequestViewModel(ownerId: ownerId, requestList: requestList)
        self._showModal = showModal
    }
    var body: some View {
        VStack {
            TextField("Description", text: $viewModel.description)
                .padding()
                .autocapitalization(.none)
                .keyboardType(.default)
            
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage).foregroundColor(.orange).font(.system(size: 12)).padding()
            }
        }
        
        Button("Make request") {
            viewModel.addRequest()
            showModal = false
        }
    }
}

struct AddRequestFormVIew_Previews: PreviewProvider {
    static var previews: some View {
        AddRequestFormView(ownerId: SampleUser.bill.id, requestList: ModelList<BarterMateRequest>.empty(), showModal: .constant(true))
    }
}
