//
//  ProductTests.swift
//  GBShoppingTests
//
//  Created by Grigory Stolyarov on 28.06.2021.
//

import XCTest
import Alamofire
@testable import GBShopping

// MARK: - Stubs Definition
struct ProductSingle: Codable {
    let name: String
    let price: Float
    let description: String
    enum CodingKeys: String, CodingKey {
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
}

struct ProductCatalog: Codable {
    let id: Int
    let name: String
    let price: Float
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price = "price"
    }
}

struct CatalogDataResult: Codable {
    let products: [ProductCatalog]
}

struct ProductSingleResult: Codable {
    let result: Int
    let product: ProductSingle
}

protocol ProductRequestFactory {
    
    func catalogData(completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void)
    func getGoodById(id: Int, completionHandler: @escaping (AFDataResponse<ProductSingleResult>) -> Void)

}

class Product: AbstractRequestFactory {

    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    
    init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }

}

extension Product: ProductRequestFactory {

    func catalogData(completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void) {
        
    }
    
    func getGoodById(id: Int, completionHandler: @escaping (AFDataResponse<ProductSingleResult>) -> Void) {
        
    }

}

extension RequestFactory {
    
    func makeProductRequestFatory() -> ProductRequestFactory {
        let errorParser = makeErrorParser()
        return Product(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
}

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
        
        product.catalogData() { response in
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
        
        product.getGoodById(id: 123) { response in
            switch response.result {
            case .success(let item):
                XCTAssertEqual(item.result, 1)
                XCTAssertEqual(item.product.name, "Ноутбук")
                getGoodByIdExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}
