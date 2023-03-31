//
//  FormView.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import SwiftUI

struct FormView: View {
    @ObservedObject var viewModel: AddItemFormViewModel
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            TextField("Name", text: $viewModel.name)
                .padding()
                .autocapitalization(.none)
                .keyboardType(.default)
            
            TextField("Description", text: $viewModel.description)
                .padding()
                .keyboardType(.phonePad)
            
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage).foregroundColor(.orange).font(.system(size: 12)).padding()
            }
            
            Button("Submit") {
                viewModel.addItem()
                showModal = false
            }.padding()
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var itemList = ModelList<BarterMateItem>.of(SampleUser.bill.id)
    
    static var viewModel = AddItemFormViewModel(itemList: itemList, ownerId: SampleUser.bill.id)
    
    static var previews: some View {
        FormView(viewModel: viewModel, showModal: .constant(true))
    }
}
