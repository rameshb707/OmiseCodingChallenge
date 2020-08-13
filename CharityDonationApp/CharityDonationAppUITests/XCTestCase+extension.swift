//
//  XCTestCase+extension.swift
//  CharityDonationAppUITests
//
//  Created by Ramesh B on 13/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func waitForActivityIndicatorToFinishSpinning(_ activityIndicatorElement: XCUIElement, timeout: TimeInterval = 30.0) {
        
        let progressHaltedPredicate = NSPredicate(format: "exists == false")
        self.expectation(for: progressHaltedPredicate, evaluatedWith: activityIndicatorElement, handler: nil)
        self.waitForExpectations(timeout: timeout, handler: nil)
    }
    

    func waitForResultWithExpectation(_ element: XCUIElement, timeout: TimeInterval = 30.0) -> XCTWaiter.Result {
        let predicate = NSPredicate(format: "exists == 1")
        let myExpectation = expectation(for: predicate, evaluatedWith: element, handler: nil)
        
        let result = XCTWaiter.wait(for: [myExpectation], timeout: timeout)
        return result
    }
    
}
