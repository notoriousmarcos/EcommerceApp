//
//  Main.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 03/07/23.
//

import Backend
import Foundation

//enum CompositionRoot {
//  case home
//  case 
//}

class Main: ObservableObject {
  static var shared = Main()

  private let httpClient = NativeHTTPClient()
  lazy var getAllProductsUseCase = RemoteGetProductsUseCase(client: RemoteGetProductsClient(client: httpClient))
  lazy var getProductUseCase = RemoteGetProductUseCase(client: RemoteGetProductClient(client: httpClient))
  lazy var getCurrentCartUseCase = RemoteGetCurrentCartUseCase(client: RemoteGetCurrentCartClient(client: httpClient))
  lazy var createCartUseCase = RemoteCreateCartUseCase(client: RemoteCreateCartClient(client: httpClient))
  lazy var updateCartUseCase = RemoteUpdateCartUseCase(client: RemoteUpdateCartClient(client: httpClient))
  lazy var addProductToCartUseCase = LocalAddProductToCartUseCase()
  lazy var removeProductInCartUseCase = LocalRemoveProductInCartUseCase()
  lazy var updateProductInCartUseCase = LocalUpdateProductInCartUseCase()
}