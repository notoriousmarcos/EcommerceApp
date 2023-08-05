//
//  ErrorExtension.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 22/02/22.
//

import Foundation

public extension Error {
    static func createError(withCode code: Int, andMessage message: String) -> Error {
        NSError(
            domain: "com.notorious.ShopCore.domain",
            code: code,
            userInfo: ["message": message]
        )
    }
}
