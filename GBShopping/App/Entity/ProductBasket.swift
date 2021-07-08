//
//  ProductBasket.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 06.07.2021.
//

import Foundation

struct ProductBasket: Codable {
    let id: Int
    let name: String
    let price: Float
    let quantity: Int
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price = "price"
        case quantity = "quantity"
    }
}
