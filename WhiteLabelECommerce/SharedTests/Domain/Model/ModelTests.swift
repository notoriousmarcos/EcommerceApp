//
//  ModelTests.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import XCTest

protocol Model: Codable, Equatable {
    func toData() -> Data?
    func toJSON() -> [String: Any]?
}

extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func toJSON() -> [String: Any]? {
        guard let data = toData() else { return nil }
        return try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        ) as? [String: Any]
    }
}

class ModelTests: XCTestCase {
    let sut = TestModel(property: "Test")
    
    func testModel_toData_ShouldCreateValidData() throws {
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
    
    func testModel_toJSON_ShouldCreateAValidJSON() {
        
        // Act
        guard let dictionary = sut.toJSON() else {
            XCTFail("Should return a valid dictionary.")
            return
        }
        
        // Assert
        XCTAssertTrue(dictionary.keys.contains("property"))
        XCTAssertEqual(dictionary["property"] as? String, sut.property)
        
    }
    
    struct TestModel: Model {
        let property: String
    }
}
