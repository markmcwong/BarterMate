//
//  RequestViewModel.swift
//  BarterMate
//
//  Created by Zico on 16/3/23.
//

import Foundation
import Combine
import Amplify

extension RequestCardView {
    class RequestViewModel: ObservableObject {
        var request: Request
        var requesterName: String?
        var dataStoreService: DataStoreService
        @Published var isLoading = true
        

        init(request: Request, manager: ServiceManager = AppServiceManager.shared) {
            self.request = request
            self.dataStoreService = manager.dataStoreService
            Task {
                await getRequesterName()
            }
        }
        
        func deleteRequest() async {
            do {
                try await dataStoreService.deleteRequest(request)
            } catch let error as DataStoreError {
                Amplify.log.error("\(#function) Error removing request - \(error.localizedDescription)")
            } catch {
                Amplify.log.error("\(#function) Error removing request - \(error.localizedDescription)")
            }
        }
        
        @MainActor
        func getRequesterName() async {
            guard isLoading else {
                return
            }
            do {
                let user = try await dataStoreService.query(User.self, byId: request.userID)
                requesterName = user?.username
                isLoading = false
            } catch let error as DataStoreError {
                Amplify.log.error("\(#function) Error finding username - \(error.localizedDescription)")
            } catch {
                Amplify.log.error("\(#function) Error removing request - \(error.localizedDescription)")
            }
        }
    }
}

