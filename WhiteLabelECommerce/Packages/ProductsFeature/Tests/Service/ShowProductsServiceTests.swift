//
//  ShowProductsServiceTests.swift
//  
//
//  Created by Marcos Vinicius Brito on 24/07/23.
//

import Backend
import Combine
import Mock
@testable import ProductsFeature
import XCTest

final class ShowProductsServiceTests: XCTestCase {

  private lazy var sut = ShowProductsService(fetchProductsUseCase: mockGetProductsUseCase)
  private var mockGetProductsUseCase = MockGetProductsUseCase()
  private var cancellables: Set<AnyCancellable> = []

  func testFetchProductsShouldFetchFirstPageOfProducts() {
    // Arrange
    mockGetProductsUseCase.response = .success(Mocks.products)
    var expectedProducts: [Product] = Mocks.products

    let callFetchExpectation = expectation(description: "Expect to call fetchProducts.")

    // When
    sut.fetchProducts(for: 0, andLimit: 1)
      .sink { status in
        //
      } receiveValue: { products in
        // Then
        XCTAssertEqual(products, expectedProducts)
        callFetchExpectation.fulfill()
      }
      .store(in: &cancellables)

    waitForExpectations(timeout: 1)
  }

  private class MockGetProductsUseCase: GetProductsUseCase {
    /// This response will be used to mock the response when fetch is called.
    var response: Result<[Product], DomainError>?
    
    func execute(offset: Int?, limit: Int?, completion: @escaping CompletionHandler) {
      guard let response = response else { return completion(.failure(.unknown(error: nil))) }
      completion(response)
    }
  }
}
