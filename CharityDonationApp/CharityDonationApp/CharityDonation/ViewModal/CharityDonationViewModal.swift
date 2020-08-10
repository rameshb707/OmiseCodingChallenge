//
//  CharityDonationViewModal.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 10/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation
import omise_ios

struct CardNumberModel {
    let cardHolderName: String
    let cardNumber: String
    let expiryMonth: String
    let expiryYear: String
    let donationAmount: String
}

protocol CharityDonationViewModalDelegate: AnyObject {
    func donationSuccessfull()
}

/// The interface which helps to fetch the token form the given card details
protocol OmiseTokenInterface {
    /**
     Fetches the valid token with the valid public key using Omise object

     - Parameters:
        - name: Card holder name who is going to donate
        - cardNumber: Card Number from which the payment is to be made
        - expiryMonth: Expiry month of the given card number
        - expiryYear: Expiry year of the given card number
     */
    func getToken(_ name: String, cardNumber number: String, expiryMonth month: String, expiryYear year: String)
}

class CharityDonationViewModal: NSObject, OmiseTokenInterface {
    
    /// Delegate
    weak var delegate: CharityDonationViewModalDelegate?
    
    /// Global property uses to make network call
    private lazy var networkManager  = NetworkManager()
    
    /// Donation amount 
    private var donationAmount: String!
    
    /// Custom Initializer to confirm the delegate who is using the viewmodal to get neccessary infromation
    init(delegate: CharityDonationViewModalDelegate) {
        self.delegate = delegate
    }
    
    /**
    Make necessary call to procceed the donation by asking the token
 
     - Parameters:
        - cardDetails: Required details to fetch the token ID
     */
    func donateToCharity(cardDetails details: CardNumberModel) {
        self.donationAmount = details.donationAmount
        self.getToken(details.cardHolderName, cardNumber: details.cardNumber, expiryMonth: details.expiryMonth, expiryYear: details.expiryYear)
        
    }
    
    /**
     On Success of fetching token procced the payment from the customer account

     - Parameters:
        - cardHolder: Card holder name who is going to donate
        - tokenID: A valid token ID fetched using omise
     */
    private func callDonateAPI(cardHolder name: String, _ tokenID: String) {
        let donationRequest = Request(endPoint: "/donations", parameters: APIParams.url(["nme": name, "token": tokenID, "amount": self.donationAmount]), httpMethod: .POST)
        networkManager.send(modelType: DonationResult.self, donationRequest) { [weak self] (donationResult, response, error) in
            if let success = (donationResult as? DonationResult)?.success, success {
                self?.delegate?.donationSuccessfull()
            }
        }
    }
}

extension CharityDonationViewModal: OmiseRequestDelegate {
    
    /**
     Fetches the valid token with the valid public key using Omise object

     - Parameters:
        - name: Card holder name who is going to donate
        - cardNumber: Card Number from which the payment is to be made
        - expiryMonth: Expiry month of the given card number
        - expiryYear: Expiry year of the given card number
     */
    func getToken(_ name: String, cardNumber number: String, expiryMonth month: String, expiryYear year: String) {
        
        /// Creating request to fetch the Omise token
        let tokenRequest = TokenRequest()
        tokenRequest.publicKey = OMISE_PUBLIC_KEY
        tokenRequest.card.name = name
        tokenRequest.card.number = number
        tokenRequest.card.expirationMonth = month
        tokenRequest.card.expirationYear = year
        
        /// Calling request token API using omise object
        let omise = Omise()
        omise.delegate = self
        omise.requestToken(tokenRequest)
    }
    
    // MARK: OmiseRequestDelegate
    func omise(onSucceededToken token: Token!) {
        callDonateAPI(cardHolder: token.card.name, token.tokenId)
    }
    
    func omise(onFailed error: Error!) {
        
    }
}
