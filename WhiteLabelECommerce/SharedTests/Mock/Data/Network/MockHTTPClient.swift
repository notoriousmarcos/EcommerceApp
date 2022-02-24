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
    var result: Data?
    var error: HTTPError?

    func dispatch(
        request: URLRequest,
        completion: @escaping ResultCompletionHandler<Data, HTTPError>
    ) {
        if let result = result {
            completion(.success(result))
        } else {
            completion(.failure(error ?? .unknown))
        }
    }
}
