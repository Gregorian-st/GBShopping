//
//  Review.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 04.07.2021.
//

import Alamofire

class Review: AbstractRequestFactory {

    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseUrl = URL(string: ConstConfig.baseURLString)!
    
    init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }

}

extension Review: ReviewRequestFactory {

    func getProductReviews(productId: Int, completionHandler: @escaping (AFDataResponse<GetProductReviewsResult>) -> Void) {
        let requestModel = GetProductReviews(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addProductReview(userId: Int,
                          productId: Int,
                          commentText: String,
                          completionHandler: @escaping (AFDataResponse<AddProductReviewResult>) -> Void) {
        let requestModel = AddProductReview(baseUrl: baseUrl,
                                            userId: userId,
                                            productId: productId,
                                            commentText: commentText)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func removeProductReview(userId: Int,
                             productId: Int,
                             commentId: Int,
                             completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void) {
        let requestModel = RemoveProductReview(baseUrl: baseUrl,
                                               userId: userId,
                                               productId: productId,
                                               commentId: commentId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

extension Review {
    
    struct GetProductReviews: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getProductReviews"
        
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
    
    struct AddProductReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addProductReview"
        
        let userId: Int
        let productId: Int
        let commentText: String
        
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "id_product": productId,
                "commentText": commentText
            ]
        }
    }
    
    struct RemoveProductReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "removeProductReview"
        
        let userId: Int
        let productId: Int
        let commentId: Int
        
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "id_product": productId,
                "id_comment": commentId
            ]
        }
    }
        
}
