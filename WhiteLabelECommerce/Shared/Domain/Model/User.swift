//
//  User.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

struct User: Model {

    // MARK: - Properties
    let id: Int
    let email: String
    let username: String
    let password: String
    let firstName: String
    let lastName: String
    let address: String
    let phone: String
}
