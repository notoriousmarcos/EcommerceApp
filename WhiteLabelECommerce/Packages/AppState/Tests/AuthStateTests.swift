@testable import AppState
import XCTest

final class AuthStateTests: XCTestCase {
    func testAuthStateIsAuthorized_ShouldBe_FalseByDefault() throws {
        let authState = AppState.AuthState()
        XCTAssertEqual(authState.isAuthorized, false)
    }
}
