//
//  ReviewTests.swift
//  GBShoppingTests
//
//  Created by Grigory Stolyarov on 04.07.2021.
//

import XCTest
@testable import GBShopping

class ReviewTests: XCTestCase {

    var requestFactory: RequestFactory?

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    func testGetProductReviews() throws {
        let review = try XCTUnwrap(requestFactory).makeReviewRequestFatory()
        let catalogDataExpectation = expectation(description: "Get Product Reviews Expectation")
        
        review.getProductReviews(productId: 123) { response in
            switch response.result {
            case .success(let productReviews):
                XCTAssertEqual(productReviews.result, 1)
                catalogDataExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAddProductReview() throws {
        let review = try XCTUnwrap(requestFactory).makeReviewRequestFatory()
        let catalogDataExpectation = expectation(description: "Add Product Review Expectation")
        
        review.addProductReview(userId: 123, productId: 123, commentText: "Very good laptop!") { response in
            switch response.result {
            case .success(let productReview):
                XCTAssertEqual(productReview.result, 1)
                catalogDataExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRemoveProductReview() throws {
        let review = try XCTUnwrap(requestFactory).makeReviewRequestFatory()
        let catalogDataExpectation = expectation(description: "Remove Product Review Expectation")
        
        review.removeProductReview(userId: 123, productId: 123, commentId: 1) { response in
            switch response.result {
            case .success(let productReview):
                XCTAssertEqual(productReview.result, 1)
                catalogDataExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
