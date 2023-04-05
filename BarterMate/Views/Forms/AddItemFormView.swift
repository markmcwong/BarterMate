//
//  FormView.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import SwiftUI

struct AddItemFormView: View {
    @ObservedObject var viewModel: AddItemFormViewModel
    @Binding var showModal: Bool
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
        viewModel.image = inputImage
    }
    
    var body: some View {
        VStack {
            TextField("Name", text: $viewModel.name)
                .padding()
                .autocapitalization(.none)
                .keyboardType(.default)
            
            TextField("Description", text: $viewModel.description)
                .padding()
                .keyboardType(.phonePad)
                .onChange(of: inputImage) { _ in
                    loadImage()
                }
            
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage).foregroundColor(.orange).font(.system(size: 12)).padding()
            }
            
            ZStack {
                Rectangle()
                    .fill(.secondary)

                Text("Tap to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)

                image?
                    .resizable()
                    .scaledToFit()
            }
            .onTapGesture {
                showingImagePicker = true
            }
            
            Button("Submit") {
                viewModel.addItem()
                showModal = false
            }.padding()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var itemList = ModelList<BarterMateItem>.of(SampleUser.bill.id)
    
    static var viewModel = AddItemFormViewModel(itemList: itemList, ownerId: SampleUser.bill.id)
    
    static var previews: some View {
        AddItemFormView(viewModel: viewModel, showModal: .constant(true))
    }
}
