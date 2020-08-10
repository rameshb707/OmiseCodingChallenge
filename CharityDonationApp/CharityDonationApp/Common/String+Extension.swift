//
//  String+Extension.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 10/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

extension String {
    
    /**
        Custom String function in order return only numbers from the entered character
        
        - Returns: String as result which holds only number
    */
    public func keepOnlyDigits() -> String {
        let ucString = self.uppercased()
        let characterSet: CharacterSet = CharacterSet(charactersIn: "0123456789")
        let stringArray = ucString.components(separatedBy: characterSet.inverted)
        let allNumbers = stringArray.joined(separator: "")
        return allNumbers
    }
}
