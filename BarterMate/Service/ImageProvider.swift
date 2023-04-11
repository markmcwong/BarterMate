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
    
    init(key: String) {
        self.cacheKey = key
        self.storageService = AmplifyStorageService()
    }
    
    public func getImageFromKey(completed: @escaping (Data) -> Void) {
        let downloadTask = storageService.downloadImage(key: cacheKey)
        Task {
            for await progress in await downloadTask.progress {
                if progress.isFinished {
                    break
                }
            }
            do {
                let data = try await downloadTask.value
                completed(data)
            } catch {
            }
        }
    }
}
