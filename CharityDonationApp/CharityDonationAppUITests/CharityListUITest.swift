//
//  CharityListUITest.swift
//  CharityDonationAppUITests
//
//  Created by Ramesh B on 13/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import XCTest

class CharityListUITest: XCTestCase {
    let application = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        application.launch()
    }

    override func tearDownWithError() throws {
    }

    func testCharityListCell() throws {
        XCTAssertTrue(application.staticTexts["Charity List"].exists)

        let result = self.waitForResultWithExpectation(application.staticTexts["Charity Name"], timeout: 50.0)
        switch result {
        case .completed:
            XCTAssertTrue(application.staticTexts["Charity Name"].exists)
            application.staticTexts["Charity Name"].tap()
            XCTAssertTrue(application.textFields["CardHolder Field"].exists)
        default:
            XCTFail()
        }
    }

}
