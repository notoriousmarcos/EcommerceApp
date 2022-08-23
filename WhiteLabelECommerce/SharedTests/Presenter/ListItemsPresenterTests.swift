//
//  ListItemsPresenterTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/08/22.
//

@testable import WhiteLabelECommerce
import XCTest

class ListItemsViewModel {
    // MARK: - Public Properties
    private(set) var items: [Product] = []

    // MARK: - Private Properties
    private let fetchAllItems: (ResultCompletionHandler<[Product], DomainError>) -> Void

    // MARK: - Init
    init(fetchAllItems: @escaping (ResultCompletionHandler<[Product], DomainError>) -> Void) {
        self.fetchAllItems = fetchAllItems
    }

    deinit {
        print("Deinit ListItemsViewModel")
    }

    // MARK: - Functions
    func onLoad() {
        fetchAllItems { [weak self] result in
            if case let .success(items) = result {
                self?.items = items
            }
        }
    }
}

class ListItemsPresenterTests: XCTestCase {

    func testListItemsPresenter_onLoad_shouldCallFetchItems() {
        // Arrange
        let expectation = expectation(description: "Expect to be called when Fetch is called.")
        let stubFetchAllItems: (ResultCompletionHandler<[Product], DomainError>) -> Void = { completion in
            expectation.fulfill()
            completion(.success(Mocks.products))
        }
        let sut = ListItemsViewModel(fetchAllItems: stubFetchAllItems)

        // Act
        sut.onLoad()
        waitForExpectations(timeout: 1)
    }

    func testListItemsViewModel_onLoad_ShouldUpdateItemsProperty() {
        // Arrange
        let expectation = expectation(description: "Expect to be called when Fetch is called.")
        let stubFetchAllItems: (ResultCompletionHandler<[Product], DomainError>) -> Void = { completion in
            expectation.fulfill()
            completion(.success(Mocks.products))
        }
        let sut = ListItemsViewModel(fetchAllItems: stubFetchAllItems)

        // Act
        sut.onLoad()
        waitForExpectations(timeout: 1)

        // Assert
        XCTAssertEqual(sut.items, Mocks.products)
    }
}
