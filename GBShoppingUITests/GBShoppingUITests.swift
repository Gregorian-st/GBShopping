//
//  GBShoppingUITests.swift
//  GBShoppingUITests
//
//  Created by Grigory Stolyarov on 20.06.2021.
//

import XCTest

class GBShoppingUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = app.scrollViews.otherElements
        
        let userNameField = elementsQuery.textFields["User Name"]
        userNameField.tap()
        app.typeText("Greg")
                
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        passwordSecureTextField.tap()
        app.typeText("GregPWD")

        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
              
        XCTAssertTrue(app.otherElements["catalogViewController"].waitForExistence(timeout: 10), app.debugDescription)
    }

}
