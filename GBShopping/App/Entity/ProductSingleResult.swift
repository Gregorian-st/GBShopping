//
//  ProductSingleResult.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 29.06.2021.
//

import Foundation

struct ProductSingleResult: Codable {
    let result: Int
    let name: String
    let price: Float
    let description: String
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
}
