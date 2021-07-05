//
//  GetProductReviewsResult.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 04.07.2021.
//

import Foundation

struct GetProductReviewsResult: Codable {
    let result: Int
    let productId: Int
    let reviews: [ProductReview]
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case productId = "id_product"
        case reviews = "reviews"
    }
}
