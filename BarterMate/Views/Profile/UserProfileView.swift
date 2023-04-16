//
//  UserProfileView.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import SwiftUI

struct UserProfileView: View {

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
            UserProfileImageView()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(lineWidth: 0.5))
                .onTapGesture {
                    showingImagePicker = true
                }
                .onChange(of: inputImage) { _ in
                    loadImage()
                }

            Text(viewModel.user.username)
                .font(.largeTitle)
                .fontWeight(.bold)
            VStack {
                Spacer()
                ProfileDetailsTabView(viewModel: viewModel)
            }
        }.sheet(isPresented: $showingImagePicker) {
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
