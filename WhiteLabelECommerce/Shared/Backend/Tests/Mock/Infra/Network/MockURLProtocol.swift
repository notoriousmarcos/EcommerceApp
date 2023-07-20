//
//  MockURLProtocol.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

import Backend
import Foundation

class MockURLProtocol: URLProtocol {
    typealias RequestHandler = ((URLRequest) -> (URLResponse, Data?, Error?))
    static var requestHandler: RequestHandler?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let (response, data, error) = Self.requestHandler?(request) else {
            client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didFailWithError: DomainError.unknown(error: nil))
            client?.urlProtocolDidFinishLoading(self)
            return
        }

        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        } else if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        //
    }
}
