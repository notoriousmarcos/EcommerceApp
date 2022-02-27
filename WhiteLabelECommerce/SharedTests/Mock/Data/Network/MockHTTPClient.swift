//
//  MockHTTPClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation
@testable import WhiteLabelECommerce
import XCTest

extension Request {
    func toString() -> String {
        baseURL
    }
}

class MockHTTPClient: HTTPClient {
    var responses: [[String: (success: Codable?, failure: DomainError?)]] = []

    func dispatch<ReturnType: Codable>(
        request: Request,
        _ completion: @escaping ResultCompletionHandler<ReturnType, DomainError>
    ) {
        guard let responseIndex = responses.firstIndex(where: { $0[request.toString()] != nil }),
              let response = responses[responseIndex][request.toString()] else {
            completion(.failure(.unknown(error: nil)))
        return
        }
        responses.remove(at: responseIndex)
        if let result = response.success as? ReturnType {
            completion(.success(result))
        } else {
            completion(.failure(response.failure ?? .unknown(error: nil)))
        }
    }
}
