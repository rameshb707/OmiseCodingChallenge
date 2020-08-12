//
//  CharityListViewModalTest.swift
//  CharityDonationAppTests
//
//  Created by Ramesh B on 12/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import XCTest
@testable import CharityDonationApp

class CharityListViewModalTest: XCTestCase {
    
    var charityListViewModal: CharityViewModal?
    var list: [Charity]?
    var charityListExpectation: XCTestExpectation?
    override func setUp()  {
        super.setUp()
        charityListViewModal = CharityViewModal(delegate: self)
    }
    
    override func tearDown() {
        super.tearDown()
        charityListViewModal = nil
        charityListExpectation = nil
        list = nil
    }
    
    func testCharityList() {
        charityListExpectation = expectation(description: "CharityList Expectation")
        charityListViewModal?.getCharityList()
        waitForExpectations(timeout: 10)
    }
    
}


extension CharityListViewModalTest: CharityViewModalDelegate {
    func charityList(_ list: [Charity]) {
        XCTAssertFalse(list.isEmpty)
        charityListViewModal?.getImage(from: (list.first?.logoUrl)!, { (data) in
            XCTAssertNotNil(data)
            self.charityListExpectation?.fulfill()
        })
    }
    
    func networkConnectionError() {
        XCTFail()
        charityListExpectation?.fulfill()
    }
    
    func charityListError(_ title: String, description message: String) {
        XCTFail()
        charityListExpectation?.fulfill()
    }
}
