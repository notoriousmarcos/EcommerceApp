//
//  ModelTests.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

@testable import ShopCore
import XCTest

class ModelTests: XCTestCase {
    private let sut = TestModel(property: "Test")

    func testModel_toData_ShouldCreateValidData() throws {
        // When
        guard let data = sut.toData() else {
            XCTFail("Should return a valid data.")
            return
        }
        let wrappedData = try? JSONDecoder().decode(
            TestModel.self,
            from: data
        )

        // Then
        XCTAssertEqual(wrappedData, sut)
    }

    func testModel_toJSON_ShouldCreateAValidJSON() {
        // When
        guard let dictionary = sut.toJSON() else {
            XCTFail("Should return a valid dictionary.")
            return
        }

        // Then
        XCTAssertTrue(dictionary.keys.contains("property"))
        XCTAssertEqual(dictionary["property"] as? String, sut.property)
    }

    private struct TestModel: Model {
        let property: String
    }
}
