//
//  NativeHTTPClient.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/02/22.
//

import Combine
import Foundation

class NativeHTTPClient: HTTPClient {
    // MARK: - Properties
    let session: URLSession
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init
    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Functions
    func dispatch(
        request: URLRequest,
        completion: @escaping ResultCompletionHandler<Data, HTTPError>
    ) {
        var subscription: AnyCancellable?
        var isComplete = false
        subscription = dispatch(request: request).sink { [weak self] result in
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    break
            }
            isComplete = true
            if let subscription = subscription {
                self?.subscriptions.remove(subscription)
            }
        } receiveValue: { response in
            completion(.success(response))
        }

        if let subscription = subscription, !isComplete {
            subscriptions.insert(subscription)
        }
    }

    private func dispatch(request: URLRequest) -> AnyPublisher<Data, HTTPError> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap({ [weak self] data, response in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw self?.handleError(response.statusCode) ?? .unknown
                }
                return data
            })
            .mapError { [weak self] error in
                guard let error = error as? HTTPError else {
                    return self?.handleError(error) ?? .unknown
                }
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func handleError(_ statusCode: Int) -> HTTPError {
        switch statusCode {
            case 400: return .badRequest
            case 401: return .unauthorized
            case 403: return .forbidden
            case 404: return .notFound
            case 500: return .serverError
            default: return .unknown
        }
    }

    private func handleError(_ error: Error) -> HTTPError {
        return .unknown
    }
}
