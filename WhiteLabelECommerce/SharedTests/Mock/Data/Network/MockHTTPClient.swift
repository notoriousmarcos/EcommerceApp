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
    var result: Any?
    var error: HTTPError?

    func dispatch<ReturnType: Codable>(
        request: URLRequest,
        completion: @escaping ResultCompletionHandler<ReturnType, HTTPError>
    ) {
        if let result = result as? ReturnType {
            completion(.success(result))
        } else {
            completion(.failure(error ?? .unknown))
        }
    }
}
