//
//  ProductCatalogResult.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 01.07.2021.
//

import Foundation

struct ProductCatalogResult: Codable {
    let pageNumber: Int
    let products: [ProductCatalog]
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page_number"
        case products = "products"
    }
}
