//
//  ProductBasket.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 06.07.2021.
//

import Foundation

struct ProductBasket: Codable {
    let product: ProductCatalog
    let quantity: Int
}
