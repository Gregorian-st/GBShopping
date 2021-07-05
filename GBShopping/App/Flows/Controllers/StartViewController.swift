//
//  StartViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 20.06.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    let requestFactory = RequestFactory()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.backgroundColor = .systemBackground
        
        authLogin()
        authChangeUserData()
        authLogout()
        authRegisterUser()
        
        productCatalogData()
        productGetGoodById()
        
        getProductReviews()
        addProductReview()
        removeProductReview()
    }
    
    // MARK: - Auth Methods
    
    private func authLogin() {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(loginName: "Somebody", password: "mypassword", cookie: "Param=Value") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func authChangeUserData() {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.changeUserData(userId: 123, loginName: "Greg", password: "GregPWD", email: "user@domain.com", gender: "m", creditCard: "1234-5678-9012-3456", bio: "Some biography") { response in
            switch response.result {
            case .success(let changeUserData):
                print(changeUserData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func authLogout() {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logout(userId: 123) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func authRegisterUser() {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.registerUser(loginName: "Greg", password: "GregPWD", email: "user@domain.com", gender: "m", creditCard: "1234-5678-9012-3456", bio: "Some biography") { response in
            switch response.result {
            case .success(let registerUser):
                print(registerUser)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Product Methods
    
    private func productCatalogData() {
        let product = requestFactory.makeProductRequestFatory()
        product.catalogData(categoryId: 2, pageNumber: 1) { response in
            switch response.result {
            case .success(let products):
                print(products)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func productGetGoodById() {
        let product = requestFactory.makeProductRequestFatory()
        product.getGoodById(productId: 123) { response in
            switch response.result {
            case .success(let product):
                print(product)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Review Methods
    
    private func getProductReviews() {
        let review = requestFactory.makeReviewRequestFatory()
        review.getProductReviews(productId: 123) { response in
            switch response.result {
            case .success(let productReviews):
                print(productReviews)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addProductReview() {
        let review = requestFactory.makeReviewRequestFatory()
        review.addProductReview(userId: 123, productId: 123, commentText: "Very good laptop!") { response in
            switch response.result {
            case .success(let productReview):
                print(productReview)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func removeProductReview() {
        let review = requestFactory.makeReviewRequestFatory()
        review.removeProductReview(userId: 123, productId: 123, commentId: 1) { response in
            switch response.result {
            case .success(let productReview):
                print(productReview)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

