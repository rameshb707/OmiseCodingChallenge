//
//  CharityDonationUITest.swift
//  CharityDonationAppUITests
//
//  Created by Ramesh B on 13/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import XCTest

class CharityDonationUITest: XCTestCase {
    let application = XCUIApplication()
    var elementsQuery:XCUIElementQuery!

    override func setUpWithError() throws {
        continueAfterFailure = false
        application.launch()
        elementsQuery = application.scrollViews.otherElements
    }

    override func tearDownWithError() throws {
    }

    func testInitialRequiredFields() throws {
        navigaterToCharityDonationScreen()
        
        XCTAssertTrue(elementsQuery.textFields["CardHolder Field"].exists)
        XCTAssertTrue(elementsQuery.textFields["CardNumber Field"].exists)
        XCTAssertTrue(elementsQuery.textFields["ExpiryMonth Field"].exists)
        XCTAssertTrue(elementsQuery.textFields["ExpiryYear Field"].exists)
        XCTAssertTrue(elementsQuery.textFields["DonationAmount Field"].exists)
        XCTAssertTrue(elementsQuery.buttons["Donate Button"].exists)

        inValidNameInputTest()
        inValidCardNumberInputTest()
        inValidExpiryMonthInputTest()
        inValidExpiryYearInputTest()
        inValidDonationAmountTest()
        validDonationAmountTest()
    }
    
    func inValidNameInputTest() {
        elementsQuery.textFields["CardHolder Field"].tap()
        elementsQuery.textFields["CardHolder Field"].typeText("")
        elementsQuery.buttons["Donate Button"].tap()
        XCTAssertTrue(application.alerts.buttons["OK"].exists)
        XCTAssertTrue(application.alerts.staticTexts["Invalid Card Details"].exists)
    }
    
    func inValidCardNumberInputTest() {
        elementsQuery.textFields["CardNumber Field"].tap()
        elementsQuery.textFields["CardNumber Field"].typeText("2342342323")
        elementsQuery.buttons["Donate Button"].tap()
        XCTAssertTrue(application.alerts.staticTexts["Invalid Card Details"].exists)
        XCTAssertTrue(application.alerts.buttons["OK"].exists)
    }
    
    func inValidExpiryMonthInputTest() {
        elementsQuery.textFields["ExpiryMonth Field"].tap()
        elementsQuery.buttons["Donate Button"].tap()
        XCTAssertTrue(application.alerts.staticTexts["Invalid Card Details"].exists)
        XCTAssertTrue(application.alerts.buttons["OK"].exists)
    }
    
    func inValidExpiryYearInputTest() {
        elementsQuery.textFields["ExpiryYear Field"].tap()
        elementsQuery.buttons["Donate Button"].tap()
        XCTAssertTrue(application.alerts.staticTexts["Invalid Card Details"].exists)
        XCTAssertTrue(application.alerts.buttons["OK"].exists)
    }
    
    func inValidDonationAmountTest() {
        
        elementsQuery.textFields["CardHolder Field"].tap()
        elementsQuery.textFields["CardHolder Field"].typeText("Ramesh B")
        
        elementsQuery.textFields["CardNumber Field"].tap()
        elementsQuery.textFields["CardNumber Field"].typeText("5598881002570158")
        
        elementsQuery.textFields["ExpiryMonth Field"].tap()
        elementsQuery.textFields["ExpiryMonth Field"].typeText("08")
        
        elementsQuery.textFields["ExpiryYear Field"].tap()
        elementsQuery.textFields["ExpiryYear Field"].typeText("2024")
        
        
        elementsQuery.textFields["DonationAmount Field"].tap()
        elementsQuery.textFields["DonationAmount Field"].typeText("0")
        
        elementsQuery.textFields["DonationAmount Field"].tap()
        elementsQuery.buttons["Donate Button"].tap()
        XCTAssertTrue(application.alerts.staticTexts["Invalid Amount"].exists)
        XCTAssertTrue(application.alerts.buttons["OK"].exists)
    }
    
    func validDonationAmountTest() {
        application.navigationBars.buttons.element(boundBy: 0).tap()
        
        navigaterToCharityDonationScreen()
        
        elementsQuery.textFields["CardHolder Field"].tap()
        elementsQuery.textFields["CardHolder Field"].typeText("Ramesh B")
        
        elementsQuery.textFields["CardNumber Field"].tap()
        elementsQuery.textFields["CardNumber Field"].typeText("5598881002570158")
        
        elementsQuery.textFields["ExpiryMonth Field"].tap()
        elementsQuery.textFields["ExpiryMonth Field"].typeText("08")
        
        elementsQuery.textFields["ExpiryYear Field"].tap()
        elementsQuery.textFields["ExpiryYear Field"].typeText("2024")
        
        
        elementsQuery.textFields["DonationAmount Field"].tap()
        elementsQuery.textFields["DonationAmount Field"].typeText("5")
        
        elementsQuery.textFields["DonationAmount Field"].tap()
        elementsQuery.buttons["Donate Button"].tap()
        
        let result = self.waitForResultWithExpectation(application.staticTexts["Donation Successfull"], timeout: 50.0)
        switch result {
        case .completed:
            XCTAssertTrue(application.staticTexts["Donation Successfull"].exists)
            XCTAssertTrue(application.staticTexts["OK"].exists)

            application.staticTexts["OK"].tap()
            XCTAssertTrue(application.staticTexts["Charity Name"].exists)

        default:
            XCTFail()
        }
    }
    
    func navigaterToCharityDonationScreen() {
        let result = self.waitForResultWithExpectation(application.staticTexts["Charity Name"], timeout: 50.0)
        switch result {
        case .completed:
            application.staticTexts["Charity Name"].tap()
        default:
            XCTAssertTrue(application.staticTexts["Charity Name"].exists)
        }
    }

}


