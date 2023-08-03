//
//  ShowProductsViewModelTests.swift
//  
//
//  Created by Marcos Vinicius Brito on 21/07/23.
//

import Backend
import Combine
import Mock
@testable import ProductsFeature
import XCTest

final class ProductsViewModelTests: XCTestCase {
  private lazy var sut = ProductsViewModel(productsService: mockProductService, cartService: mockCartService)
  private var mockProductService = MockProductsService()
  private var mockCartService = MockCartService()
  private var cancellables: Set<AnyCancellable> = []

  func testFetchProductsShouldFetchFirstPageOfProducts() {
    // Arrange
    var expectedProducts: [[ProductViewItem]] = [
      [],
      Mocks.productsItemView
    ]
    let paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    let viewStateExpectation = expectation(description: "Expect to updateViewState.")
    viewStateExpectation.expectedFulfillmentCount = 3
    let callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    callFetchExpectation.expectedFulfillmentCount = 2

    mockProductService.response = [.success(Mocks.products)]
    mockProductService.fetchProductsParamsClosure = { offset, limit in
      XCTAssertEqual(offset, 0)
      XCTAssertEqual(limit, 10)
      paramsOfFetchExpectation.fulfill()
    }

    var expectedViewStates: [ProductsViewModel.ViewState?] = [
      nil,
      .loading,
      .finished
    ]

    sut.$viewState.sink { viewState in
      // Then
      let expectedViewState = expectedViewStates.removeFirst()
      XCTAssertEqual(viewState, expectedViewState)
      viewStateExpectation.fulfill()
    }
    .store(in: &cancellables)

    sut.$products.sink { products in
      // Then
      let expectedProducts = expectedProducts.removeFirst()
      XCTAssertEqual(products, expectedProducts)
      callFetchExpectation.fulfill()
    }
    .store(in: &cancellables)

    // When
    sut.fetchProducts(shouldReset: true)

    waitForExpectations(timeout: 1)
  }

  func testFetchProductshouldFetchFirstPageOfProductsAndReceiveError() {
    // Arrange
    let paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    let callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    let viewStateExpectation = expectation(description: "Expect to updateViewState.")
    let errorExpectation = expectation(description: "Expect to receive error.")
    errorExpectation.expectedFulfillmentCount = 2
    viewStateExpectation.expectedFulfillmentCount = 3

    mockProductService.response = [.failure(.unknown)]

    var expectedViewStates: [ProductsViewModel.ViewState?] = [
      nil,
      .loading,
      .finished
    ]

    mockProductService.fetchProductsParamsClosure = { offset, limit in
      XCTAssertEqual(offset, 0)
      XCTAssertEqual(limit, 10)
      paramsOfFetchExpectation.fulfill()
    }

    var expectedErrors: [ProductsServiceError?] = [
      nil,
      .unknown
    ]

    sut.$error.sink { error in
      // Then
      let expectedError = expectedErrors.removeFirst()
      XCTAssertEqual(error as? ProductsServiceError, expectedError)
      errorExpectation.fulfill()
    }
    .store(in: &cancellables)

    sut.$viewState.sink { viewState in
      // Then
      let expectedViewState = expectedViewStates.removeFirst()
      XCTAssertEqual(viewState, expectedViewState)
      viewStateExpectation.fulfill()
    }
    .store(in: &cancellables)

    sut.$products.sink { products in
      // Then
      XCTAssertEqual(products, [])
      callFetchExpectation.fulfill()
    }
    .store(in: &cancellables)

    // When
    sut.fetchProducts(shouldReset: true)

    waitForExpectations(timeout: 1)
  }

  func testFetchNextProductsShouldFetchNextPageAndReturnMoreProducts() {
    // Arrange
    let sut = ProductsViewModel(productsService: mockProductService, cartService: mockCartService, pageLimit: 1)
    var paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    var callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    callFetchExpectation.expectedFulfillmentCount = 2
    var viewStateExpectation = expectation(description: "Expect to updateViewState.")
    viewStateExpectation.expectedFulfillmentCount = 3

    var expectedProducts: [[ProductViewItem]] = [
      [],
      [Mocks.productsItemView.first!],
      Array(Mocks.productsItemView[0..<2])
    ]
    var expectedParams: [(Int, Int)] = [
      (0, 1), // offset 0 and pageLimit 1
      (1, 1) // offset 1 and pageLimit 1
    ]

    var expectedViewStates: [ProductsViewModel.ViewState?] = [
      nil,
      .loading,
      .finished
    ]

    mockProductService.response = [
      .success([Mocks.products.first!]),
      .success([Mocks.products[1]])
    ]

    mockProductService.fetchProductsParamsClosure = { offset, limit in
      let (expectedOffset, expectedLimit) = expectedParams.removeFirst()
      XCTAssertEqual(offset, expectedOffset)
      XCTAssertEqual(limit, expectedLimit)
      paramsOfFetchExpectation.fulfill()
    }

    sut.$viewState.sink { viewState in
      // Then
      let expectedViewState = expectedViewStates.removeFirst()
      XCTAssertEqual(viewState, expectedViewState)
      viewStateExpectation.fulfill()
    }
    .store(in: &cancellables)

    sut.$products.sink { products in
      // Then
      let expectedProducts = expectedProducts.removeFirst()
      XCTAssertEqual(products, expectedProducts)
      callFetchExpectation.fulfill()
    }
    .store(in: &cancellables)

    // When
    sut.fetchProducts(shouldReset: true)

    waitForExpectations(timeout: 1)

    paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    viewStateExpectation = expectation(description: "Expect to updateViewState.")
    viewStateExpectation.expectedFulfillmentCount = 2

    expectedViewStates = [
      .fetching,
      .finished
    ]

    sut.fetchProducts()

    waitForExpectations(timeout: 1)
  }

  func testFetchProductsShouldFetchFirstPageAlways() {
    // Arrange
    let sut = ProductsViewModel(productsService: mockProductService, cartService: mockCartService, pageLimit: 1)
    var paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    var callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    var viewStateExpectation = expectation(description: "Expect to updateViewState.")
    callFetchExpectation.expectedFulfillmentCount = 2
    viewStateExpectation.expectedFulfillmentCount = 3

    var expectedProducts: [[ProductViewItem]] = [
      [],
      [Mocks.productsItemView.first!],
      Array(Mocks.productsItemView[0..<2]),
      [Mocks.productsItemView.first!]
    ]

    var expectedParams: [(Int, Int)] = [
      (0, 1), // offset 0 and pageLimit 1
      (1, 1), // offset 1 and pageLimit 1
      (0, 1) // offset 0 and pageLimit 1
    ]

    var expectedViewStates: [ProductsViewModel.ViewState?] = [
      nil,
      .loading,
      .finished
    ]

    mockProductService.response = [
      .success([Mocks.products.first!]),
      .success([Mocks.products[1]]),
      .success([Mocks.products.first!])
    ]

    mockProductService.fetchProductsParamsClosure = { offset, limit in
      let (expectedOffset, expectedLimit) = expectedParams.removeFirst()
      XCTAssertEqual(offset, expectedOffset)
      XCTAssertEqual(limit, expectedLimit)
      paramsOfFetchExpectation.fulfill()
    }

    sut.$viewState.sink { viewState in
      // Then
      let expectedViewState = expectedViewStates.removeFirst()
      XCTAssertEqual(viewState, expectedViewState)
      viewStateExpectation.fulfill()
    }
    .store(in: &cancellables)

    sut.$products.sink { products in
      // Then
      let expectedProducts = expectedProducts.removeFirst()
      XCTAssertEqual(products, expectedProducts)
      callFetchExpectation.fulfill()
    }
    .store(in: &cancellables)

    // When
    sut.fetchProducts(shouldReset: true)

    waitForExpectations(timeout: 1)

    paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    viewStateExpectation = expectation(description: "Expect to updateViewState.")
    viewStateExpectation.expectedFulfillmentCount = 2

    expectedViewStates = [
      .fetching,
      .finished
    ]

    sut.fetchProducts()

    waitForExpectations(timeout: 1)

    paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    viewStateExpectation = expectation(description: "Expect to updateViewState.")
    viewStateExpectation.expectedFulfillmentCount = 2

    expectedViewStates = [
      .loading,
      .finished
    ]

    sut.fetchProducts(shouldReset: true)

    waitForExpectations(timeout: 1)
  }

  func testFetchNextProductsShouldFetchNextPage() {
    // Arrange
    let sut = ProductsViewModel(productsService: mockProductService, cartService: mockCartService, pageLimit: 5)
    var paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    var callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    var viewStateExpectation = expectation(description: "Expect to updateViewState.")
    callFetchExpectation.expectedFulfillmentCount = 2
    viewStateExpectation.expectedFulfillmentCount = 3

    var expectedProducts: [[ProductViewItem]] = [
      [],
      Array(Mocks.productsItemView[0..<5]),
      Mocks.productsItemView
    ]

    var expectedParams: [(Int, Int)] = [
      (0, 5), // offset 0 and pageLimit 5
      (5, 5) // offset 5 and pageLimit 5
    ]

    var expectedViewStates: [ProductsViewModel.ViewState?] = [
      nil,
      .loading,
      .finished
    ]

    mockProductService.response = [
      .success(Array(Mocks.products[0..<5])),
      .success(Array(Mocks.products[5..<7]))
    ]

    mockProductService.fetchProductsParamsClosure = { offset, limit in
      let (expectedOffset, expectedLimit) = expectedParams.removeFirst()
      XCTAssertEqual(offset, expectedOffset)
      XCTAssertEqual(limit, expectedLimit)
      paramsOfFetchExpectation.fulfill()
    }

    sut.$viewState.sink { viewState in
      // Then
      let expectedViewState = expectedViewStates.removeFirst()
      XCTAssertEqual(viewState, expectedViewState)
      viewStateExpectation.fulfill()
    }
    .store(in: &cancellables)

    sut.$products.sink { products in
      // Then
      let expectedProducts = expectedProducts.removeFirst()
      XCTAssertEqual(products, expectedProducts)
      callFetchExpectation.fulfill()
    }
    .store(in: &cancellables)

    // When
    sut.fetchProducts(shouldReset: true)

    waitForExpectations(timeout: 1)

    paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    viewStateExpectation = expectation(description: "Expect to updateViewState.")
    viewStateExpectation.expectedFulfillmentCount = 2

    expectedViewStates = [
      .fetching,
      .finished
    ]

    sut.fetchNextPage(Mocks.productsItemView.first { $0.id == 2 }!)

    waitForExpectations(timeout: 1)
  }

  func testFetchNextProductsShouldNotFetchNextPage() {
    // Arrange
    let sut = ProductsViewModel(productsService: mockProductService, cartService: mockCartService, pageLimit: 5)
    var paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    var callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    var viewStateExpectation = expectation(description: "Expect to updateViewState.")
    callFetchExpectation.expectedFulfillmentCount = 2
    viewStateExpectation.expectedFulfillmentCount = 3

    var expectedProducts: [[ProductViewItem]] = [
      [],
      Array(Mocks.productsItemView[0..<5])
    ]

    var expectedParams: [(Int, Int)] = [
      (0, 5) // offset 0 and pageLimit 5
    ]

    var expectedViewStates: [ProductsViewModel.ViewState?] = [
      nil,
      .loading,
      .finished
    ]

    mockProductService.response = [
      .success(Array(Mocks.products[0..<5]))
    ]

    mockProductService.fetchProductsParamsClosure = { offset, limit in
      let (expectedOffset, expectedLimit) = expectedParams.removeFirst()
      XCTAssertEqual(offset, expectedOffset)
      XCTAssertEqual(limit, expectedLimit)
      paramsOfFetchExpectation.fulfill()
    }

    sut.$viewState.sink { viewState in
      // Then
      let expectedViewState = expectedViewStates.removeFirst()
      XCTAssertEqual(viewState, expectedViewState)
      viewStateExpectation.fulfill()
    }
    .store(in: &cancellables)

    sut.$products.sink { products in
      // Then
      let expectedProducts = expectedProducts.removeFirst()
      XCTAssertEqual(products, expectedProducts)
      callFetchExpectation.fulfill()
    }
    .store(in: &cancellables)

    // When
    sut.fetchProducts(shouldReset: true)

    waitForExpectations(timeout: 1)

    paramsOfFetchExpectation = expectation(description: "Expect to call fetchProducts on service.")
    paramsOfFetchExpectation.isInverted = true
    callFetchExpectation = expectation(description: "Expect to be called when viewModel products change.")
    callFetchExpectation.isInverted = true
    viewStateExpectation = expectation(description: "Expect to updateViewState.")
    viewStateExpectation.isInverted = true

    sut.fetchNextPage(Mocks.productsItemView.first { $0.id == 1 }!)

    waitForExpectations(timeout: 1)
  }

  func testAddToCartShouldCallAddToCartService() {
    // Arrange
    let expectedProduct = Mocks.productsItemView.first
    mockCartService.addToCartParamsClosure = { product in
      // Assert
      XCTAssertEqual(product, expectedProduct)
    }

    // Act
    sut.addToCart(expectedProduct!)
  }

  // MARK: - Helpers

  private class MockProductsService: ProductsService {
    /// This response will be used to mock the response when fetch is called.
    var response: [Result<[Product], ProductsServiceError>?]?

    /// This closure will be called when fetchProducts is called.
    var fetchProductsParamsClosure: ((_ offset: Int?, _ limit: Int?) -> Void)?

    init() { }

    func fetchProducts(for offset: Int? = nil, andLimit limit: Int? = nil) -> AnyPublisher<[Product], ProductsServiceError> {
      fetchProductsParamsClosure?(offset, limit)
      guard let response = response?.removeFirst() else {
        return Fail(error: ProductsServiceError.unknown)
          .eraseToAnyPublisher()
      }
      switch response {
        case .success(let output):
          return Just(output)
            .setFailureType(to: ProductsServiceError.self)
            .eraseToAnyPublisher()
        case .failure(let error):
          return Fail(error: error)
            .eraseToAnyPublisher()
      }
    }
  }

  private class MockCartService: CartService {
    var addToCartParamsClosure: ((ProductViewItem) -> Void)?

    func addToCart(_ product: ProductViewItem) {
      addToCartParamsClosure?(product)
    }
  }
}

extension Mocks {
  static var productsItemView: [ProductViewItem] {
    products.map { product in
      ProductViewItem(
        id: product.id,
        title: product.title,
        price: product.price,
        category: CategoryItemView(
          id: product.category.id,
          name: product.category.name,
          imageURL: URL(string: product.category.imageURL ?? "")
        ),
        description: product.description,
        imagesURL: product.imagesURL.compactMap { URL(string: $0) }
      )
    }
  }
}
