//
//  MockHTTPClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation
@testable import WhiteLabelECommerce
import XCTest

class MockHTTPClient: HTTPClient {
    let url = URL(string: "https://google.com")!
    var result: Codable?
    var error: DomainError?

    func dispatch<ReturnType: Codable>(
        request: Request,
        _ completion: @escaping ResultCompletionHandler<ReturnType, DomainError>
    ) {
        if let result = result as? ReturnType {
            completion(.success(result))
        } else {
            completion(.failure(error ?? .unknown(error: nil)))
        }
    }
}
