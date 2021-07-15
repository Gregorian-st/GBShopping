//
//  CatalogViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 12.07.2021.
//

import UIKit

class CatalogViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCatalogData()
        productGetGoodById()
        
        getProductReviews()
        addProductReview()
        removeProductReview()
        
        addToBasket()
        deleteFromBasket()
        getBasket()
        payBasket()
    }
    
    // MARK: - Product Methods
    
    private func productCatalogData() {
        let product = requestFactory.makeProductRequestFatory()
        product.catalogData(categoryId: 2, pageNumber: 1) { response in
            switch response.result {
            case .success(let products):
                logging(products)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    private func productGetGoodById() {
        let product = requestFactory.makeProductRequestFatory()
        product.getGoodById(productId: 123) { response in
            switch response.result {
            case .success(let product):
                logging(product)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Review Methods
    
    private func getProductReviews() {
        let review = requestFactory.makeReviewRequestFatory()
        review.getProductReviews(productId: 123) { response in
            switch response.result {
            case .success(let productReviews):
                logging(productReviews)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    private func addProductReview() {
        let review = requestFactory.makeReviewRequestFatory()
        review.addProductReview(userId: 123,
                                productId: 123,
                                commentText: "Very good laptop!") { response in
            switch response.result {
            case .success(let productReview):
                logging(productReview)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    private func removeProductReview() {
        let review = requestFactory.makeReviewRequestFatory()
        review.removeProductReview(userId: 123,
                                   productId: 123,
                                   commentId: 1) { response in
            switch response.result {
            case .success(let productReview):
                logging(productReview)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Basket Methods
    
    private func addToBasket() {
        let basket = requestFactory.makeBasketRequestFatory()
        basket.addToBasket(productId: 123, quantity: 1) { response in
            switch response.result {
            case .success(let addToBasketResult):
                logging(addToBasketResult)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    private func deleteFromBasket() {
        let basket = requestFactory.makeBasketRequestFatory()
        basket.deleteFromBasket(productId: 123) { response in
            switch response.result {
            case .success(let addToBasketResult):
                logging(addToBasketResult)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    private func getBasket() {
        let basket = requestFactory.makeBasketRequestFatory()
        basket.getBasket(userId: 123) { response in
            switch response.result {
            case .success(let basket):
                logging(basket)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    private func payBasket() {
        let basket = requestFactory.makeBasketRequestFatory()
        basket.payBasket(userId: 123) { response in
            switch response.result {
            case .success(let payBasketResult):
                logging(payBasketResult)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    

    
}
