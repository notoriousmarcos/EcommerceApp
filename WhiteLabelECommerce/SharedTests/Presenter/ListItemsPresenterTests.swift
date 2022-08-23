//
//  ListItemsPresenterTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/08/22.
//

@testable import WhiteLabelECommerce
import XCTest

struct ListItemsViewModel {
    let fetchAllItems: (ResultCompletionHandler<[Product], DomainError>) -> Void

    func onLoad() {
        fetchAllItems { result in

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
}
