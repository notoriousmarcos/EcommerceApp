//
//  ShowProductsService.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import Backend
import Combine
import Foundation

protocol ProductsService {
  func fetchProducts(for offset: Int?, andLimit limit: Int?) -> AnyPublisher<[Product], ShowProductsServiceError>
}

class ShowProductsService: ProductsService {

  private var fetchProductsUseCase: GetProductsUseCase

  init(fetchProductsUseCase: GetProductsUseCase) {
    self.fetchProductsUseCase = fetchProductsUseCase
  }

  func fetchProducts(for offset: Int? = nil, andLimit limit: Int? = nil) -> AnyPublisher<[Product], ShowProductsServiceError> {
    Deferred {
      Future { [weak self] promise in
        self?.fetchProductsUseCase.execute(offset: offset, limit: limit) { result in
          switch result {
            case .success(let products):
              promise(.success(products))
            case .failure(let error):
              promise(.failure(.unknown))
          }
        }
      }
    }
    .eraseToAnyPublisher()
  }
}
