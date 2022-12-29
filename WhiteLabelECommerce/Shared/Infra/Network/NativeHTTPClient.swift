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
    func dispatch<ReturnType: Codable>(
        request: Request,
        _ completion: @escaping ResultCompletionHandler<ReturnType, DomainError>
    ) {
        guard let request = request.asURLRequest() else {
            completion(.failure(.requestError(error: .urlError)))
            return
        }
        var subscription: AnyCancellable?
        var isComplete = false
        subscription = dispatch(request: request).sink { [weak self] result in
            switch result {
                case .failure(let error):
                    completion(.failure(.requestError(error: error)))
                case .finished:
                    break
            }
            isComplete = true
            if let subscription = subscription {
                self?.subscriptions.remove(subscription)
            }
        } receiveValue: { response in
            do {
                let parsedValue = try JSONDecoder().decode(ReturnType.self, from: response)
                completion(.success(parsedValue))
            } catch {
                completion(.failure(.errorOnParsing(error: error)))
            }
        }

        if let subscription = subscription, !isComplete {
            subscriptions.insert(subscription)
        }
    }

    private func dispatch(request: URLRequest) -> AnyPublisher<Data, HTTPError> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw HTTPError(rawValue: response.statusCode)
                }
                return data
            })
            .mapError { error in
                guard let error = error as? HTTPError else {
                    if let error = error as? URLError {
                        return HTTPError(rawValue: error.errorCode)
                    }
                    return .unknown
                }
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
