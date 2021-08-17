//
//  BasketRequestFactory.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 06.07.2021.
//

import Alamofire

protocol BasketRequestFactory {
    
    func addToBasket(userId: Int, productId: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void)
    func deleteFromBasket(userId: Int, productId: Int, completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void)
    func getBasket(userId: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void)
    func payBasket(userId: Int, completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void)
    
}

