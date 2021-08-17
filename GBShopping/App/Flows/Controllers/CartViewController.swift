//
//  CartViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 14.07.2021.
//

import UIKit

class CartViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToBasket()
        deleteFromBasket()
        getBasket()
        payBasket()
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
