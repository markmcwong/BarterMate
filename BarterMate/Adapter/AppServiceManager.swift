//
//  AppServiceManager.swift
//  BarterMate
//
//  Created by Zico on 16/3/23.
//

class AppServiceManager: ServiceManager {

    private init() {}
    
    static let shared = AppServiceManager()
    
    let authService: AuthService = AmplifyAuthService()
    let dataStoreService: DataStoreService = AmplifyDataStoreService()
    let storageService: StorageService = AmplifyStorageService()
    
    func configure() {
        dataStoreService.configure()
    }
}
