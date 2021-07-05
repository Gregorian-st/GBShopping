//
//  AddProductReviewResult.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 04.07.2021.
//

import Foundation

struct AddProductReviewResult: Codable {
    let result: Int
    let commentId: Int
    let userMessage: String
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case commentId = "id_comment"
        case userMessage = "userMessage"
    }
}
