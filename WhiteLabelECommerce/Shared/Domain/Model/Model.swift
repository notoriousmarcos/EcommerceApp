//
//  Model.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

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
