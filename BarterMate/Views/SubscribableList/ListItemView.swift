//
//  ListItemView.swift
//  BarterMate
//
//  Created by mark on 7/4/2023.
//

import Foundation
import SwiftUI

protocol ListItemView<itemType>: View {
    associatedtype itemType: ListElement
    var item: itemType { get }
    var model: ListViewModel<itemType>? { get }
    init(item: itemType, model: ListViewModel<itemType>?)
    
//    associatedtype Content: View
    static func build(for item: itemType, model: ListViewModel<itemType>?) -> Self
}

//protocol ListItemView<itemType>: View {
//associatedtype itemType
//var item: itemType { get }
//var user: BarterMateUser {get set}
//init(item: itemType, user: BarterMateUser)
//
////    associatedtype Content: View
//static func build(for item: itemType, user: BarterMateUser) -> Self
//}

