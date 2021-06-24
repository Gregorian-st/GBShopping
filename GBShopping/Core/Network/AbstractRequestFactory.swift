//
//  AbstractRequestFactory.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Alamofire

protocol AbstractRequestFactory {
    
    var errorParser: AbstractErrorParser { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }
    
    @discardableResult
    func request<T: Decodable>(request: URLRequestConvertible, completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest
    
}

extension AbstractRequestFactory {
    
    @discardableResult
    public func request<T: Decodable>(request: URLRequestConvertible, completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest {
        return sessionManager.request(request).responseCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
    }
    
}
