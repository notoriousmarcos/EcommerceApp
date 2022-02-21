//
//  CreateCartRequest.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

import Foundation

struct CreateCartRequest: Request {
    // MARK: - Typealias
    typealias ReturnType = Cart
    // MARK: - Properties
    let baseURL: String = "https://fakestoreapi.com/carts"
    let method: HTTPMethod = .post
    let contentType: String = "application/json"
    let params: [String: Any]? = nil
    let body: [String: Any]?
    let headers: [String: String]? = nil

    init(cart: Cart) {
        self.body = cart.toJSON()
    }
}

extension Cart {
    enum CodingKeys: CodingKey {
        case id, userId, date, products
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(date.toString(), forKey: .date)
        try container.encode(products, forKey: .products)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(Int.self, forKey: .id)
        let userId = try values.decode(Int.self, forKey: .userId)
        let dateString = try values.decode(String.self, forKey: .date)
        let products = try values.decode([CartItem].self, forKey: .products)
        guard let date = dateString.toDate() else {
            throw DecodingError.typeMismatch(
                Date.self,
                .init(
                    codingPath: [CodingKeys.date],
                    debugDescription: "Date is nil",
                    underlyingError: nil
                )
            )
        }

        self = Cart(
            id: id,
            userId: userId,
            date: date,
            products: products
        )
    }
}
