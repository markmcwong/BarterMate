//
//  ImageProvider.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import Amplify
import Combine
import Foundation
import SwiftUI

class ImageProvider {
    public var cacheKey: String
    private var storageService: StorageService
    private var subscribers = Set<AnyCancellable>()
    
    init(key: String, manager: ServiceManager = AppServiceManager.shared) {
        self.cacheKey = key
        self.storageService = manager.storageService
    }
    
    public func getImageFromKey(completed: @escaping (Data) -> Void) {
        let downloadTask = Amplify.Storage.downloadData(key: cacheKey)

        Task {
            for await progress in await downloadTask.progress {
                // optionally update a progress bar here
            }
            do {
                let data = try await downloadTask.value
                print("Image loaded")
                completed(data)
            } catch {
                print("Cannot download image")
            }
        }
    }
}
