//
//  BasketTests.swift
//  GBShoppingTests
//
//  Created by Grigory Stolyarov on 06.07.2021.
//

import XCTest
@testable import GBShopping

class BasketTests: XCTestCase {

    var requestFactory: RequestFactory?

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    func testAddToBasket() throws {
        let basket = try XCTUnwrap(requestFactory).makeBasketRequestFatory()
        let addToBasketExpectation = expectation(description: "Add To Basket Expectation")
        
        basket.addToBasket(productId: 123, quantity: 1) { response in
            switch response.result {
            case .success(let addToBasketResult):
                XCTAssertEqual(addToBasketResult.result, 1)
                addToBasketExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDeleteFromBasket() throws {
        let basket = try XCTUnwrap(requestFactory).makeBasketRequestFatory()
        let deleteFromBasketExpectation = expectation(description: "Delete From Basket Expectation")
        
        basket.deleteFromBasket(productId: 123) { response in
            switch response.result {
            case .success(let deleteFromBasketResult):
                XCTAssertEqual(deleteFromBasketResult.result, 1)
                deleteFromBasketExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetBasket() throws {
        let basket = try XCTUnwrap(requestFactory).makeBasketRequestFatory()
        let getBasketExpectation = expectation(description: "Get Basket Expectation")
        
        basket.getBasket(userId: 123) { response in
            switch response.result {
            case .success(let basket):
                XCTAssertGreaterThan(basket.amount, -1)
                getBasketExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPayBasket() throws {
        let basket = try XCTUnwrap(requestFactory).makeBasketRequestFatory()
        let payBasketExpectation = expectation(description: "Pay Basket Expectation")
        
        basket.payBasket(userId: 123) { response in
            switch response.result {
            case .success(let payBasketResult):
                XCTAssertEqual(payBasketResult.result, 1)
                payBasketExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}
