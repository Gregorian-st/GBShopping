//
//  AuthRequestFactory.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Alamofire

protocol AuthRequestFactory {
    
    func login(loginName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void)
    func registerUser(loginName: String, password: String, userName: String, userLastName: String,  completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)
    func changeUserData(loginName: String, password: String, userName: String, userLastName: String,  completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void)
    
}
