//
//  ErrorExtension.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 22/02/22.
//

import Foundation

public extension Error {
    static func createError(withCode code: Int, andMessage message: String) -> Error {
        NSError(
            domain: "com.notorious.WhiteLabelECommerce.domain",
            code: code,
            userInfo: ["message": message]
        )
    }
}
