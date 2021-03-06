//
//  ProductTests.swift
//  GBShoppingTests
//
//  Created by Grigory Stolyarov on 28.06.2021.
//

import XCTest
@testable import GBShopping

// MARK: - Tests

class ProductTests: XCTestCase {

    var requestFactory: RequestFactory?

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    func testCatalogData() throws {
        let product = try XCTUnwrap(requestFactory).makeProductRequestFatory()
        let catalogDataExpectation = expectation(description: "Catalog Data Expectation")
        
        product.catalogData(categoryId: 1, pageNumber: 1) { response in
            switch response.result {
            case .success(let catalog):
                XCTAssertGreaterThan(catalog.products.count, 0)
                catalogDataExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetGoodById() throws {
        let product = try XCTUnwrap(requestFactory).makeProductRequestFatory()
        let getGoodByIdExpectation = expectation(description: "Get Good By ID Expectation")
        
        product.getGoodById(productId: 101) { response in
            switch response.result {
            case .success(let product):
                XCTAssertEqual(product.result, 1)
                getGoodByIdExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}
