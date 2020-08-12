//
//  CharityDonactionViewModalTest.swift
//  CharityDonationAppTests
//
//  Created by Ramesh B on 12/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import XCTest
@testable import CharityDonationApp

class CharityDonactionViewModalTest: XCTestCase {

    var charityListViewModal: CharityDonationViewModal?
    var charityDonationExpectation: XCTestExpectation?
    var charityDonationInvalidExpectation: XCTestExpectation?
    var charityInvalidAmountExpectation: XCTestExpectation?

    override func setUp()  {
        super.setUp()
        charityListViewModal = CharityDonationViewModal(delegate: self)

    }

    override func tearDown()  {
        super.tearDown()

    }

    func testWithvalidCardDetails() {
        charityDonationExpectation = expectation(description: "CharityDonation Expectation")
        let cardModel = CardNumberModel(cardHolderName: "Ramesh B", cardNumber: "5598881002570158", expiryMonth: "08", expiryYear: "2024", donationAmount: "10")
        charityListViewModal?.donateToCharity(cardDetails: cardModel)
        waitForExpectations(timeout: 10)
    }
    
    func testWithInvalidAmount() {
        charityInvalidAmountExpectation = expectation(description: "CharityDonation Invalid Amount")
        let cardModel = CardNumberModel(cardHolderName: "Ramesh B", cardNumber: "", expiryMonth: "08", expiryYear: "2024", donationAmount: "0")
        charityListViewModal?.donateToCharity(cardDetails: cardModel)
        waitForExpectations(timeout: 10)
    }
    
    func testInvalidCardDetails() {
        charityDonationInvalidExpectation = expectation(description: "CharityDonation Invalid Expectation")
        let cardModel = CardNumberModel(cardHolderName: "Ramesh B", cardNumber: "", expiryMonth: "08", expiryYear: "2024", donationAmount: "10")
        charityListViewModal?.donateToCharity(cardDetails: cardModel)
        waitForExpectations(timeout: 10)
    }

}

extension CharityDonactionViewModalTest: CharityDonationViewModalDelegate {
    func donationSuccessfull() {
        charityDonationExpectation?.fulfill()
    }
    
    func insufficientBalanceFailed() {
        XCTFail()
        charityDonationExpectation?.fulfill()
    }
    
    func donationError(_ title: String, description message: String) {
        XCTAssert(title == "Invalid Card Details")
        charityDonationInvalidExpectation?.fulfill()
    }
    
    func enterValidAmount() {
        charityInvalidAmountExpectation?.fulfill()
    }
    
    func networkConnectionError() {
        XCTFail()
        charityDonationExpectation?.fulfill()
        charityDonationInvalidExpectation?.fulfill()
    }
    
    
}
