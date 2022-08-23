//
//  ListItemsPresenterTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 23/08/22.
//

@testable import WhiteLabelECommerce
import Combine
import XCTest

enum ViewState<T, E: Error> {
    case idle
    case loaded(_ data: T)
    case failed(_ error: E)
}

class ListItemsViewModel {
    // MARK: - Public Properties
    @Published private(set) var state: ViewState<[Product], Error> = .idle

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
            switch result {
                case.success(let products):
                    self?.state = .loaded(products)
                case .failure(let error):
                    self?.state = .failed(error)
            }
        }
    }
}

class ListItemsPresenterTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()

    func testListItemsViewModel_onLoadWithSuccess_ShouldNotifySubscribersWhenFinished() {
        // Arrange
        let expectation = expectation(description: "Expect to be called when state change.")
        let stubFetchAllItems: (ResultCompletionHandler<[Product], DomainError>) -> Void = { completion in
            completion(.success(Mocks.products))
        }
        let sut = ListItemsViewModel(fetchAllItems: stubFetchAllItems)

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
        let sut = ListItemsViewModel(fetchAllItems: stubFetchAllItems)

        // Act
        subscriptions.insert(sut.$state.sink { state in
            // Assert
            if case let .failed(error) = state {
                expectation.fulfill()
                XCTAssert(error is DomainError)
            }
        })
        sut.onLoad()
        waitForExpectations(timeout: 1)
    }

}
