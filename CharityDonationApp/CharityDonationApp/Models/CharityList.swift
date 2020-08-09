//
//  CharityList.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

/// Represents the List of charity
struct CharityList: Codable {
    
    /// Holds the total number of the charity list
    let total: Int
    
    /// List of Charity which are available
    let data: [Charity]
}
