//
//  ProductReview.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 04.07.2021.
//

import Foundation

struct ProductReview: Codable {
    let commentId: Int
    let userId: Int
    let commentText: String
    enum CodingKeys: String, CodingKey {
        case commentId = "id_comment"
        case userId = "id_user"
        case commentText = "commentText"
    }
}
