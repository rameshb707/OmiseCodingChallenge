//
//  Charity.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation


/// Represents the charity information
struct Charity: Codable {
    
    /// Charity ID
    let id: Int
    
    /// Charity Name for which the customer wish to donate
    let name: String
    
    /// Charity image logo URL
    let logoUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoUrl = "logo_url"
    }

}



