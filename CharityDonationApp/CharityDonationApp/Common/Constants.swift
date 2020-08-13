//
//  Constants.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 09/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import UIKit

/// Charity list endpaoint
let CHARITYLIST_END_POINT = "/charities"

/// Donation endpint
let CHARITY_DONATION_END_POINT = "/donations"

/// Height for the charity list holding cell
let CharityCell_Height_Constant: CGFloat = 200

/// Public key to obtain Omise token
let OMISE_PUBLIC_KEY = "pkey_test_5ktpt1ts4o4fuw7p72x"

let CARD_NUMBER_COUNT = 16

let CARD_EXPIRY_YEAR = 4


/// Error title and messages
let  NETWORK_CONNECTION_FAIL_TITLE = "Connection Failed"

let  NETWORK_CONNECTION_FAIL_DESCRIPTION = "Failed to connect the network"

let INVALID_AMOUNT = "Invalid Amount"

let INVALID_AMOUNT_DESCRIPTION = "Please Enter valid Amount"

let INSUFFICIENT_BALANCE = "Insufficient Balance"

let INSUFFICIENT_BALANCE_DESCRIPTION = "Card has insufficient balance."

let INVALID_CARD_DETAILS = "Invalid Card Details"

let INVALID_CARD_DETAILS_DESCRIPTION = "Please enter the valid card details"

let EMPTY_CHARITY_LIST = "No Charities available"

let EMPTY_CHARITY_LIST_ESCRIPTION = "There is no charities available to donate"
