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
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init( errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
    
}

extension Auth: AuthRequestFactory {
    
    func login(loginName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, loginName: loginName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func registerUser(loginName: String, password: String, userName: String, userLastName: String,  completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        let requestModel = RegisterUser(baseUrl: baseUrl, loginName: loginName, password: password, userName: userName, userLastName: userLastName)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(loginName: String, password: String, userName: String, userLastName: String,  completionHandler: @escaping (AFDataResponse<OnlyResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl, loginName: loginName, password: password, userName: userName, userLastName: userLastName)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension Auth {
    
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        let loginName: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": loginName,
                "password": password
            ]
        }
    }
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        var parameters: Parameters? {
            return [:]
        }
    }
    
    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "changeUserData.json"
        let loginName: String
        let password: String
        let userName: String
        let userLastName: String
        var parameters: Parameters? {
            return [
                "username": loginName,
                "password": password,
                "user_name": userName,
                "user_lastname": userLastName
            ]
        }
    }
    
    struct RegisterUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "registerUser.json"
        let loginName: String
        let password: String
        let userName: String
        let userLastName: String
        var parameters: Parameters? {
            return [
                "username": loginName,
                "password": password,
                "user_name": userName,
                "user_lastname": userLastName
            ]
        }
    }
    
}
