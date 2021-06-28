//
//  AuthTests.swift
//  GBShoppingTests
//
//  Created by Grigory Stolyarov on 28.06.2021.
//

import XCTest
@testable import GBShopping

class AuthTests: XCTestCase {
    
    var requestFactory: RequestFactory?

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }

    func testLogin() throws {
        let auth = try XCTUnwrap(requestFactory).makeAuthRequestFatory()
        let signInExpectation = expectation(description: "Sign In Expectation")
        
        auth.login(loginName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                XCTAssertEqual(login.user.id, 123)
                signInExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testChangeUserData() throws {
        let auth = try XCTUnwrap(requestFactory).makeAuthRequestFatory()
        let changeUserDataExpectation = expectation(description: "Change User Data Expectation")
        
        auth.changeUserData(loginName: "Somebody", password: "mypassword", userName: "Nick", userLastName: "Cage") { response in
            switch response.result {
            case .success(let changeUserData):
                XCTAssertEqual(changeUserData.result, 1)
                changeUserDataExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testLogout() throws {
        let auth = try XCTUnwrap(requestFactory).makeAuthRequestFatory()
        let logoutExpectation = expectation(description: "Logout Expectation")
        
        auth.logout() { response in
            switch response.result {
            case .success(let logout):
                XCTAssertEqual(logout.result, 1)
                logoutExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRegisterUser() throws {
        let auth = try XCTUnwrap(requestFactory).makeAuthRequestFatory()
        let registerUserExpectation = expectation(description: "Register User Expectation")
        
        auth.registerUser(loginName: "Greg", password: "GregPWD", userName: "Gregor", userLastName: "Joiner") { response in
            switch response.result {
            case .success(let registerUser):
                XCTAssertEqual(registerUser.result, 1)
                XCTAssertEqual(registerUser.userMessage, "Регистрация прошла успешно!")
                registerUserExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
