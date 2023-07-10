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

    session
      .dataTaskPublisher(for: request)
      .tryMap { data, response in
        guard let response = response as? HTTPURLResponse, case 200..<300 = response.statusCode else {
          throw HTTPError(rawValue: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        return try JSONDecoder().decode(ReturnType.self, from: data)
      }
      .mapError { error -> DomainError in
        guard let error = error as? HTTPError else {
          if let error = error as? URLError {
            return .requestError(error: .init(rawValue: error.errorCode))
          } else if let error = error as? DecodingError {
            return .errorOnParsing(error: error)
          }
          return .requestError(error: .unknown)
        }
        return .requestError(error: error)
      }
      .receive(on: DispatchQueue.main)
      .sink { result in
        switch result {
          case .failure(let error):
            completion(.failure(error))
          case .finished:
            break
        }
      } receiveValue: { parsedValue in
          completion(.success(parsedValue))
      }
      .store(in: &subscriptions)
  }
}
