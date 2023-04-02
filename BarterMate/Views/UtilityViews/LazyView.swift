//
//  LazyView.swift
//  BarterMate
//
//  Created by Zico on 2/4/23.
//

import SwiftUI

struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
        self.content()
    }
}

//struct LazyView_Previews: PreviewProvider {
//    static var previews: some View {
//        LazyView()
//    }
//}
