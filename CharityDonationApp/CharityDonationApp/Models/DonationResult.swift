//
//  DonationResult.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 10/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

struct DonationResult: Codable {
    
    /// Indicates status of donation to charity
    var success: Bool
    
    /// Error code indicates the type of failure
    var errorCode: String
    
    /// Error Description: Reson for the failure
    var errorMessage: String
    
    private enum CodingKeys: String, CodingKey {
        case success
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}

