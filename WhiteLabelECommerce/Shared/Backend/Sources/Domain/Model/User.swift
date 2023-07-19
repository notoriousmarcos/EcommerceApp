//
//  User.swift
//  Backend
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation

public struct User: Model {

  // MARK: - Properties
  public let id: Int
  public let email: String
  public let username: String
  public var auth: Authentication?
  public let firstName: String
  public let lastName: String
  public let address: String
  public let phone: String

  public init(
    id: Int,
    email: String,
    username: String,
    auth: Authentication? = nil,
    firstName: String,
    lastName: String,
    address: String,
    phone: String
  ) {
    self.id = id
    self.email = email
    self.username = username
    self.auth = auth
    self.firstName = firstName
    self.lastName = lastName
    self.address = address
    self.phone = phone
  }
}
