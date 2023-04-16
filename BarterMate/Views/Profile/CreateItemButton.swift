//
//  CreateItemButton.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import Foundation
import SwiftUI

struct CreateItemButton: View {
    var body: some View {
        Image(systemName: "plus.app")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)

    }
}

struct CreateItemButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateItemButton()
    }
}
