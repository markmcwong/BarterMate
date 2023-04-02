//
//  ProfileButtonsView.swift
//  BarterMate
//
//  Created by Zico on 31/3/23.
//

import SwiftUI

struct ProfileButtonsView: View {
    var body: some View {
        HStack {
            Spacer()
            CreateItemButton()
            Spacer()
        }
    }
}

struct ProfileButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButtonsView()
    }
}
