//
//  Product.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 29.06.2021.
//

import Alamofire

class Product: AbstractRequestFactory {

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

extension Product: ProductRequestFactory {

    func catalogData(categoryId: Int, pageNumber: Int, completionHandler: @escaping (AFDataResponse<ProductCatalogResult>) -> Void) {
        let requestModel = CatalogData(baseUrl: baseUrl, categoryId: categoryId, pageNumber: pageNumber)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getGoodById(productId: Int, completionHandler: @escaping (AFDataResponse<ProductSingleResult>) -> Void) {
        let requestModel = GetGoodById(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}


extension Product {
    
    struct CatalogData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "catalogData"
        
        let categoryId: Int
        let pageNumber: Int
        
        var parameters: Parameters? {
            return [
                "id_category": categoryId,
                "page_number": pageNumber
            ]
        }
    }
    
    struct GetGoodById: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getGoodById"
        
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
    
}
