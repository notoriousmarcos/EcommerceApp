//
//  ListItemsPresenterTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/08/22.
//

import Combine
@testable import WhiteLabelECommerce
import XCTest

class ListItemsPresenterTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()

    func testListItemsViewModel_onLoadWithSuccess_ShouldNotifySubscribersWhenFinished() {
        // Arrange
        let expectation = expectation(description: "Expect to be called when state change.")
        let stubFetchAllItems: (ResultCompletionHandler<[Product], DomainError>) -> Void = { completion in
            completion(.success(Mocks.products))
        }
        let sut = ProductListViewModel(fetchAllItems: stubFetchAllItems)

        // Act
        subscriptions.insert(sut.$state.sink { state in
            // Assert
            if case let .loaded(items) = state {
                expectation.fulfill()
                XCTAssertEqual(items, Mocks.products)
            }
        })
        sut.onLoad()
        waitForExpectations(timeout: 1)
    }

    func testListItemsViewModel_onLoadWithFailure_ShouldNotifySubscribersWhenFinished() {
        // Arrange
        let expectation = expectation(description: "Expect to be called when state change.")
        let stubFetchAllItems: (ResultCompletionHandler<[Product], DomainError>) -> Void = { completion in
            completion(.failure(.unknown(error: nil)))
        }
        let sut = ProductListViewModel(fetchAllItems: stubFetchAllItems)

        // Act
        subscriptions.insert(sut.$state.sink { state in
            // Assert
            if case let .failed(error) = state, case .unknown = error {
                expectation.fulfill()
            }
        })
        sut.onLoad()
        waitForExpectations(timeout: 1)
    }

    func testListItemsViewModel_reloadWithSuccess_ShouldNotifySubscribersWhenFinished() {
        // Arrange
        let expectation = expectation(description: "Expect to be called when state change.")
        let stubFetchAllItems: (ResultCompletionHandler<[Product], DomainError>) -> Void = { completion in
            completion(.success(Mocks.products))
        }
        let sut = ProductListViewModel(fetchAllItems: stubFetchAllItems)

        // Act
        subscriptions.insert(sut.$state.sink { state in
            // Assert
            if case let .loaded(items) = state {
                expectation.fulfill()
                XCTAssertEqual(items, Mocks.products)
            }
        })
        sut.reload()
        waitForExpectations(timeout: 1)
    }
}
