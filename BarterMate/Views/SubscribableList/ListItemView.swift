//
//  ListItemView.swift
//  BarterMate
//
//  Created by mark on 7/4/2023.
//

import Foundation
import SwiftUI

protocol ListItemView<itemType>: View {
    associatedtype itemType
    var item: itemType { get }
    init(item: itemType)
    
//    associatedtype Content: View
    static func build(for item: itemType    ) -> Self
}
