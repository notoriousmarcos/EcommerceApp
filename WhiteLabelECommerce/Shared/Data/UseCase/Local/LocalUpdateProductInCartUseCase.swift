//
//  LocalUpdateProductInCartUseCase.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 21/02/22.
//

import Foundation

struct LocalUpdateProductInCartUseCase: UpdateProductInCartUseCase {
    func execute(
        _ product: Product,
        withQuantity quantity: Int,
        inCart cart: Cart,
        completion: @escaping CompletionHandler
    ) {
        var products = cart.products
        guard let itemIndex = products.firstIndex(where: { $0.productId == product.id }) else {
            completion(.success(cart))
            return
        }

        if quantity > 0 {
            products[itemIndex].setQuantity(quantity)
        } else {
            products.removeAll(where: { $0.productId == product.id })
        }
        completion(
            .success(
                Cart(
                    id: cart.id,
                    userId: cart.userId,
                    date: cart.date,
                    products: products
                )
            )
        )
    }
}
