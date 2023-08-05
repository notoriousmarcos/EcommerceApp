//
//  RemoteGetUserClient.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 27/02/22.
//

import Foundation

struct RemoteGetUserClient: GetUserClient {
    // MARK: - Properties
    private let client: HTTPClient

    // MARK: - init
    init(client: HTTPClient) {
        self.client = client
    }

    func dispatch(
        userId: Int,
        _ completion: @escaping ResultCompletionHandler<User, DomainError>
    ) {
        client.dispatch(
            request: GetUserRequest(id: userId)
        ) { result in
            completion(result)
        }
    }
}
