//
//  ItemImageView.swift
//  BarterMate
//
//  Created by Zico on 3/4/23.
//

import SwiftUI

struct ItemImageView: View {
    @ObservedObject var item: BarterMateItem
    @State var image: Image? = nil
    
    init(item: BarterMateItem) {
        self.item = item
        self.image = image
    }
    
    func loadImage() {
        guard let data = item.imageData else {
            return
        }
        guard let uiImage = UIImage(data: data) else {
            return
        }
        image = Image(uiImage: uiImage)
    }
    
    var body: some View {
        HStack {
            if item.imageData == nil {
                Image(systemName: "person")
            } else {
                image?
                    .resizable()
            }
        }
        .onChange(of: item.imageData) { _ in
            loadImage()
        }
        .onAppear {
            loadImage()
        }

    }
}

struct ItemImageView_Previews: PreviewProvider {
    static var previews: some View {
        ItemImageView(item: SampleItem.guitar)
    }
}
