//
//  HTTPClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol HTTPClient {
    func dispatch<ReturnType: Codable>(
        request: URLRequest,
        completion: @escaping ResultCompletionHandler<ReturnType, HTTPError>
    )
}
