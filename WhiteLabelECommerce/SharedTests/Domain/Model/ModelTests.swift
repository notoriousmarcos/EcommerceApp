//
//  ModelTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import XCTest

protocol Model: Codable, Equatable {
    func toData() -> Data?
}

extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

class ModelTests: XCTestCase {
    func testModel_toData_ShouldCreateValidData() throws {
        // Arrange
        let sut = TestModel(property: "Test")
        
        // Act
        guard let data = sut.toData() else {
            XCTFail("Should return a valid data.")
            return
        }
        let wrappedData = try? JSONDecoder().decode(
            TestModel.self,
            from: data
        )
        
        // Assert
        XCTAssertEqual(wrappedData, sut)
    }
    
    struct TestModel: Model {
        let property: String
    }
}
