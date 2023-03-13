//
//  StorageService.swift
//  BarterMate
//
//  Created by Zico on 14/3/23.
//

import Amplify
import Foundation
import Combine

protocol StorageService {
    func uploadImage(key: String, _ data: Data) -> StorageUploadDataTask
    func downloadImage(key: String) -> StorageDownloadDataTask
    func removeImage(key: String) async throws -> String
}
