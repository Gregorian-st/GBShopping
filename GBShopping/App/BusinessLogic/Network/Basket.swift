//
//  Basket.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 06.07.2021.
//

import Alamofire

class Basket: AbstractRequestFactory {

    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseUrl = ConstConfig.baseURLString
    
    init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }

}

extension Basket: BasketRequestFactory {
    
    func addToBasket(userId: Int, productId: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void) {
        let requestModel = AddToBasketData(baseUrl: baseUrl, userId: userId, productId: productId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteFromBasket(userId: Int, productId: Int, completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void) {
        let requestModel = DeleteFromBasketData(baseUrl: baseUrl, userId: userId, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getBasket(userId: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void) {
        let requestModel = GetBasketData(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func payBasket(userId: Int, completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void) {
        let requestModel = PayBasketData(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension Basket {
    
    struct AddToBasketData: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "addToBasket"
        
        let userId: Int
        let productId: Int
        let quantity: Int
        
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "id_product": productId,
                "quantity": quantity
            ]
        }
    }
    
    struct DeleteFromBasketData: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "deleteFromBasket"
        
        let userId: Int
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "id_product": productId
            ]
        }
    }
    
    struct GetBasketData: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "getBasket"
        
        let userId: Int
        
        var parameters: Parameters? {
            return [
                "id_user": userId
            ]
        }
    }
    
    struct PayBasketData: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "payBasket"
        
        let userId: Int
        
        var parameters: Parameters? {
            return [
                "id_user": userId
            ]
        }
    }
    
}
