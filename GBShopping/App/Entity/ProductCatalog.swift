//
//  ProductCatalog.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 29.06.2021.
//

import Foundation

struct ProductCatalog: Codable {
    let id: Int
    let name: String
    let price: Float
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price = "price"
    }
}
