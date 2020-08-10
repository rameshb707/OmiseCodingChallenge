//
//  CharityDonationViewController.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 10/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import UIKit
import omise_ios

class CharityDonationViewController: UIViewController,UITextFieldDelegate, TextDidChangeDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var cardHolderNameTextField: CustomTextField!
    @IBOutlet weak var cardNumberTextField: CustomTextField!
    @IBOutlet weak var expiryMonthTextField: CustomTextField!
    @IBOutlet weak var expiryYearTextField: CustomTextField!
    @IBOutlet weak var donationAmountTextField: CustomTextField!
    
    // MARK: Properties
    var viewModal: CharityDonationViewModal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Basic setup of the view
        setUpView()
        
        /// ViewModal Object with CharityDonationViewController confirming through initializer
        viewModal = CharityDonationViewModal(delegate: self)
    }
    
    /**
        Confroms to the custom text field delgate and defines the input fromat of the texfields
     */
    private func setUpView() {
        
        cardHolderNameTextField.delegate = self
        cardHolderNameTextField.delegateCimbTextField = self
        
        cardNumberTextField.delegate = self
        cardNumberTextField.delegateCimbTextField = self
        cardNumberTextField.setNumberFormatting(formattingPattern: "#### #### #### ####")
        
        expiryMonthTextField.delegate = self
        expiryMonthTextField.delegateCimbTextField = self
        expiryMonthTextField.setNumberFormatting(formattingPattern: "##")
        
        expiryYearTextField.delegate = self
        expiryYearTextField.delegateCimbTextField = self
        expiryYearTextField.setNumberFormatting(formattingPattern: "####")
        
        donationAmountTextField.delegate = self
        donationAmountTextField.delegateCimbTextField = self
        donationAmountTextField.setNumberFormatting(formattingPattern: "#,###,###")
    }
    
    // MARK: Actions
    @IBAction func donate(_ sender: Any) {
        
        let cardModal = CardNumberModel(cardHolderName: cardHolderNameTextField.getText(bWithOutFormat: false), cardNumber: cardNumberTextField.getText(), expiryMonth: expiryMonthTextField.getText(), expiryYear: expiryYearTextField.getText(), donationAmount: donationAmountTextField.getText())
        
        /// Donate the amount 
        viewModal?.donateToCharity(cardDetails: cardModal)
    }

}

extension CharityDonationViewController: CharityDonationViewModalDelegate {
    func donationSuccessfull() {
        // TODO: navigate to success screen
    }
}

