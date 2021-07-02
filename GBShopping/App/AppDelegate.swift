//
//  AppDelegate.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 20.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let requestFactory = RequestFactory()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let auth = requestFactory.makeAuthRequestFatory()
        let product = requestFactory.makeProductRequestFatory()
        
        auth.login(loginName: "Somebody", password: "mypassword", cookie: "Param=Value") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        auth.changeUserData(userId: 123, loginName: "Greg", password: "GregPWD", email: "user@domain.com", gender: "m", creditCard: "1234-5678-9012-3456", bio: "Some biography") { response in
            switch response.result {
            case .success(let changeUserData):
                print(changeUserData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        auth.logout(userId: 123) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        auth.registerUser(loginName: "Greg", password: "GregPWD", email: "user@domain.com", gender: "m", creditCard: "1234-5678-9012-3456", bio: "Some biography") { response in
            switch response.result {
            case .success(let registerUser):
                print(registerUser)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        product.catalogData(categoryId: 2, pageNumber: 1) { response in
            switch response.result {
            case .success(let products):
                print(products)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        product.getGoodById(productId: 123) { response in
            switch response.result {
            case .success(let product):
                print(product)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

