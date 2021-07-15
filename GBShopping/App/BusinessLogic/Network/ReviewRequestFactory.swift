//
//  ReviewRequestFactory.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 04.07.2021.
//

import Alamofire

protocol ReviewRequestFactory {
    
    func getProductReviews(productId: Int, completionHandler: @escaping (AFDataResponse<GetProductReviewsResult>) -> Void)
    func addProductReview(userId: Int,
                          productId: Int,
                          commentText: String,
                          completionHandler: @escaping (AFDataResponse<AddProductReviewResult>) -> Void)
    func removeProductReview(userId: Int,
                             productId: Int,
                             commentId: Int,
                             completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void)

}
