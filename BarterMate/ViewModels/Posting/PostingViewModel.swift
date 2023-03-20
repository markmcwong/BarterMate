//
//  PostingViewModel.swift
//  BarterMate
//
//  Created by Zico on 18/3/23.
//

import Amplify
import Foundation
import SwiftUI

class PostingViewModel: ObservableObject {
    
    var posting: Posting
    var image: Image?
    var postingService: PostingService
    // var storageService: StorageService
    
    init(posting: Posting, manager: ServiceManager = AppServiceManager.shared) {
        self.posting = posting
        self.postingService = manager.postingService
        // self.storageService = manager.storageService
        // loadImage()
    }
    
    func deletePost() async {
        do {
            try await postingService.deletePosting(posting)
        } catch let error as StorageError {
            Amplify.log.error("Failed to delete Posting in Storage: \(error.localizedDescription)")
        } catch let error as DataStoreError {
            Amplify.log.error("Failed to delete Posting in DataStore: \(error.localizedDescription)")
        } catch {
            Amplify.log.error("Failed to delete Posting")
        }
    }
    
    func loadImage() {
        let provider = ImageProvider(key: posting.id)
        provider.getImageFromKey { data in
            let uiImage = UIImage(data: data)
            let loadedImage = Image(uiImage: uiImage!)
            self.image = loadedImage
        }
    }
    
}



