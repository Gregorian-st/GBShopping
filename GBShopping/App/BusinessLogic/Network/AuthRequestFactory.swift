//
//  AuthRequestFactory.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Alamofire

protocol AuthRequestFactory {
    
    func login(loginName: String, password: String, cookie: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void)
    func registerUser(loginName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)
    func changeUserData(userId: Int, loginName: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void)
    
}
