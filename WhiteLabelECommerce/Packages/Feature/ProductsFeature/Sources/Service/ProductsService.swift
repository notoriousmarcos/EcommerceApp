//
//  ProductsService.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import Backend
import Combine
import Foundation

public protocol ProductsService {
  func fetchProducts(for offset: Int?, andLimit limit: Int?) -> AnyPublisher<[Product], ProductsServiceError>
}

public final class ShowProductsService: ProductsService {
  private var fetchProductsUseCase: GetProductsUseCase

  public init(fetchProductsUseCase: GetProductsUseCase) {
    self.fetchProductsUseCase = fetchProductsUseCase
  }

  public func fetchProducts(
    for offset: Int? = nil,
    andLimit limit: Int? = nil
  ) -> AnyPublisher<[Product], ProductsServiceError> {
    Deferred {
      Future { [weak self] promise in
        self?.fetchProductsUseCase.execute(offset: offset, limit: limit) { result in
          switch result {
            case .success(let products):
              promise(.success(products))
            case .failure(let error):
              promise(.failure(self?.mapError(error) ?? .unknown))
          }
        }
      }
    }
    .eraseToAnyPublisher()
  }

  private func mapError(_ domainError: DomainError) -> ProductsServiceError {
    switch domainError {
      case .unknown:
        return .unknown
      case .requestError:
        return .requestFail
      case .errorOnParsing:
        return .decoding
      case .guardError:
        return .guardError
    }
  }

  deinit {
#if DEBUG
    // print("Deinit \(Self.self)")
#endif
  }
}
