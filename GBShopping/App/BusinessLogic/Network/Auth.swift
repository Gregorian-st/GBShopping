//
//  Auth.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.06.2021.
//

import Alamofire

class Auth: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = ConstConfig.baseURLString
    
    init( errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
    
}

extension Auth: AuthRequestFactory {
    
    func login(loginName: String,
               password: String,
               cookie: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl,
                                 loginName: loginName,
                                 password: password,
                                 cookie: cookie)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func registerUser(loginName: String,
                      password: String,
                      name: String,
                      surname: String,
                      email: String,
                      gender: String,
                      creditCard: String,
                      bio: String,
                      completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        let requestModel = RegisterUser(baseUrl: baseUrl,
                                        loginName: loginName,
                                        password: password,
                                        name: name,
                                        surname: surname,
                                        email: email,
                                        gender: gender,
                                        creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(userId: Int,
                        loginName: String,
                        password: String,
                        name: String,
                        surname: String,
                        email: String,
                        gender: String,
                        creditCard: String,
                        bio: String,
                        completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl,
                                          userId: userId,
                                          loginName: loginName,
                                          password: password,
                                          name: name,
                                          surname: surname,
                                          email: email,
                                          gender: gender,
                                          creditCard: creditCard,
                                          bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension Auth {
    
    struct Login: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "login"
        
        let loginName: String
        let password: String
        let cookie: String
        
        var parameters: Parameters? {
            return [
                "username": loginName,
                "password": password,
                "cookie": cookie
            ]
        }
    }
    
    struct Logout: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "logout"
        
        let userId: Int
        
        var parameters: Parameters? {
            return [
                "id_user": userId
            ]
        }
    }
    
    struct ChangeUserData: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "changeUserData"
        
        let userId: Int
        let loginName: String
        let password: String
        let name: String
        let surname: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "username": loginName,
                "password": password,
                "name": name,
                "surname": surname,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }
    
    struct RegisterUser: RequestRouter {
        let baseUrl: String
        let method: HTTPMethod = .post
        let path: String = "register"
        
        let loginName: String
        let password: String
        let name: String
        let surname: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        
        var parameters: Parameters? {
            return [
                "username": loginName,
                "password": password,
                "name": name,
                "surname": surname,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }
    
}
