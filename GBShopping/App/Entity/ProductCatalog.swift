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
    let image: String
    let price: Float
    let description: String
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "name"
        case image = "image"
        case price = "price"
        case description = "description"
    }
    
    init() {
        id = 0
        name = ""
        image = ""
        price = 0
        description = ""
    }
}
