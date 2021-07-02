//
//  ProductRequestFactory.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 29.06.2021.
//

import Alamofire

protocol ProductRequestFactory {
    
    func catalogData(categoryId: Int, pageNumber: Int, completionHandler: @escaping (AFDataResponse<ProductCatalogResult>) -> Void)
    func getGoodById(productId: Int, completionHandler: @escaping (AFDataResponse<ProductSingleResult>) -> Void)

}
