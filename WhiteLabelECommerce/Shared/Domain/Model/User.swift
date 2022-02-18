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
    var auth: Authentication?
    let firstName: String
    let lastName: String
    let address: String
    let phone: String
}
