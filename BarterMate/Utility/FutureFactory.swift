//
//  FutureFactory.swift
//  BarterMate
//
//  Created by mark on 8/4/2023.
//

import Foundation
import Combine

// allows converting any async await into Future easily
extension Future where Failure == Error {
    convenience init(asyncFunc: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let result = try await asyncFunc()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}

extension Future {
    convenience init(asyncFunc: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let result = try await asyncFunc()
                    promise(.success(result))
                }
//                catch {
//                    promise(.failure(error))
//                }
            }
        }
    }
}
