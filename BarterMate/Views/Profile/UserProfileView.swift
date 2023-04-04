//
//  UserProfileView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct UserProfileView: View {
    
    @State var showModal: Bool = false
    @ObservedObject var viewModel: UserProfileViewModel
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ScrollViewReader { scrollView in
                    LazyVStack {
                        UserProfileImageView()
                            .frame(width: 200,  height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(lineWidth: 1))
                            .onTapGesture {
                                showingImagePicker = true
                            }
                            .onChange(of: inputImage) { _ in
                                loadImage()
                            }
                        
                        Text(viewModel.user.username)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Item " + "\(viewModel.itemList.elements.count)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        MyItemListView(viewModel: ListViewModel(user: viewModel.user, modelList: viewModel.itemList))
                    }
                }
            }
            ProfileButtonsView().onTapGesture {
                showModal = true
            }
        }.overlay(ModalView(displayView: {
            FormView(viewModel: AddItemFormViewModel(itemList: viewModel.itemList,
                                                     ownerId: viewModel.user.id),
                     showModal: $showModal)
        }, showModal: $showModal))
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static let viewModel = { () -> UserProfileViewModel in
        var viewModel = UserProfileViewModel(user: SampleUser.bill)
        return viewModel
    }()
    
    static var previews: some View {
        UserProfileView(viewModel: viewModel)
    }
}

