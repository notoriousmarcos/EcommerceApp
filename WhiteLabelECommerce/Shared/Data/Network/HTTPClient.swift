//
//  HTTPClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 18/02/22.
//

import Foundation

protocol HTTPClient {
    func dispatch(
        request: URLRequest,
        completion: @escaping ResultCompletionHandler<Data, HTTPError>
    )
}
