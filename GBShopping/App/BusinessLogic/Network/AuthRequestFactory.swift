//
//  AuthRequestFactory.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Alamofire

protocol AuthRequestFactory {
    
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    
}
