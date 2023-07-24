//
//  ProductViewModelTests.swift
//  
//
//  Created by Marcos Vinicius Brito on 23/07/23.
//

import Mock
@testable import ProductsFeature
import XCTest

class ProductViewModelTests: XCTestCase {
  private let product = ProductViewItem(
    id: 1,
    title: "Sample Product",
    price: 9.99,
    category: CategoryItemView(
      id: 1,
      name: "Sample Category",
      imageURL: URL(string: "")
    ),
    description: "This is a sample product",
    imagesURL: []
  )
}
