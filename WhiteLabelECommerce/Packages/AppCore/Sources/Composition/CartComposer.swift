//
//  File.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import CartFeature
import ShopCore
import SwiftUI

// MARK: - CartComposer
extension AppView {
  var cartView: AnyView {
    AnyView(
      CartView(viewModel: viewModel)
    )
  }

  private var viewModel: some CartViewModel {
    DefaultCartViewModel(
      container: container,
      cartService: cartService,
      getProductHandler: shopCore.remoteGetProductUseCase.execute(id:completion:)
    )
  }

  var cartService: CartService {
    DefaultCartService(
      container: container,
      addProductHandler: shopCore.localAddProductToCartUseCase.execute(_:toCart:completion:),
      updateProductHandler: shopCore.localUpdateProductInCartUseCase.execute(_:withQuantity:inCart:completion:),
      removeProductHandler: shopCore.localRemoveProductInCartUseCase.execute(_:inCart:completion:)
    )
  }
}
