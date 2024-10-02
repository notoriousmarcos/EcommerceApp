//
//  ShowProductsServiceTests.swift
//  
//
//  Created by Marcos Vinicius Brito on 24/07/23.
//

import Combine
import Mock
@testable import ProductsFeature
import ShopCore
import XCTest

final class ShowProductsServiceTests: XCTestCase {
  private lazy var sut = ShowProductsService(fetchProductsUseCase: mockGetProductsUseCase)
  private var mockGetProductsUseCase = MockGetProductsUseCase()
  private var cancellables: Set<AnyCancellable> = []

  func testFetchProductsShouldFetchProducts() {
    // Arrange
    mockGetProductsUseCase.response = .success(Mocks.products)
    let expectedProducts: [Product] = Mocks.products

    let callFetchExpectation = expectation(description: "Expect to call fetchProducts.")

    // When
    sut.fetchProducts(for: 0, andLimit: 1)
      .sink { _ in
        //
      } receiveValue: { products in
        // Then
        XCTAssertEqual(products, expectedProducts)
        callFetchExpectation.fulfill()
      }
      .store(in: &cancellables)

    waitForExpectations(timeout: 1)
  }

  func testFetchProductsShouldFailAndMapError() {
    // Arrange

    let mockResponses: [
      (response: Result<[Product], DomainError>, expected: Result<[Product], ProductsServiceError>)
    ] = [
      (
        .failure(.errorOnParsing(error: DecodingError.createError(withCode: 1, andMessage: "Error"))),
        .failure(.decoding)
      ),
      (
        .failure(.requestError(error: .badRequest)),
        .failure(.requestFail)
      ),
      (
        .failure(.guardError(error: NSError())),
        .failure(.guardError)
      ),
      (
        .failure(.unknown(error: nil)),
        .failure(.unknown)
      )
    ]

    mockResponses.forEach { tests in
      let expectation = createFetchProductsExpectation(with: tests.response, expectedResult: tests.expected)

      wait(for: [expectation], timeout: 1)
    }
  }

  private func createFetchProductsExpectation(
    with mockResponse: Result<[Product], DomainError>,
    expectedResult: Result<[Product], ProductsServiceError>
  ) -> XCTestExpectation {
    let expectation = XCTestExpectation(description: "FetchProductsExpectation")

    // Set up your mockGetProductsUseCase or inject a mock service here.
    // For this example, I'm using a simple Combine publisher to simulate the fetchProducts call.
    // Arrange
    mockGetProductsUseCase.response = mockResponse

    sut.fetchProducts()
      .sink(receiveCompletion: { completion in
        switch completion {
          case .failure(let error):
            if case let .failure(expectedError) = expectedResult, error == expectedError {
              expectation.fulfill()
            }
          case .finished:
            break
        }
      }, receiveValue: { products in
        if case let .success(expectedProducts) = expectedResult {
          XCTAssertEqual(products, expectedProducts)
          expectation.fulfill()
        }
      })
      .store(in: &cancellables)

    return expectation
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
