//
//  ServiceManager.swift
//  BarterMate
//
//  Created by Zico on 15/3/23.
//

protocol ServiceManager {
    var dataStoreService: DataStoreService { get }
    var storageService: StorageService { get }
    
    func configure()
    
}
