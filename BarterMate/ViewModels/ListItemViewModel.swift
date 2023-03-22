//
//  GenericListItemViewModel.swift
//  BarterMate
//
//  Created by mark on 22/3/2023.
//

import Foundation
import SwiftUI

protocol GenericListItemViewModel : ObservableObject {
    associatedtype ListItemType: BarterMateModel
    var item: ListItemType { get set }
    init(item: ListItemType)
}
