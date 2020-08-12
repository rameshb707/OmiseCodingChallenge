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
    
    /// Storyboard identifier to fetch the viewcontroller
    static let identifier: String = String(describing: CharityDonationViewController.self)
    
    // MARK: Outlets
    @IBOutlet weak var cardHolderNameTextField: CustomTextField!
    @IBOutlet weak var cardNumberTextField: CustomTextField!
    @IBOutlet weak var expiryMonthTextField: CustomTextField!
    @IBOutlet weak var expiryYearTextField: CustomTextField!
    @IBOutlet weak var donationAmountTextField: CustomTextField!
    
    // MARK: Properties
    var viewModal: CharityDonationViewModal?
    
    var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Basic setup of the view
        setUpView()
        
        /// ViewModal Object with CharityDonationViewController confirming through initializer
        viewModal = CharityDonationViewModal(delegate: self)
        
        /// Adds activity indicator on doing paymnet
        activityIndicator = self.showActivityIndicatory(uiView: self.view)
        activityIndicator?.stopAnimating()
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
        if (cardHolderNameTextField.getText(bWithOutFormat: false).count > 0) || (cardNumberTextField.getText().count == CARD_NUMBER_COUNT) || (expiryMonthTextField.getText().count > 0)  || (expiryYearTextField.getText().count == CARD_EXPIRY_YEAR) || (donationAmountTextField.getText().count > 0 ) {
            activityIndicator?.startAnimating()

            let cardModal = CardNumberModel(cardHolderName: cardHolderNameTextField.getText(bWithOutFormat: false), cardNumber: cardNumberTextField.getText(), expiryMonth: expiryMonthTextField.getText(), expiryYear: expiryYearTextField.getText(), donationAmount: donationAmountTextField.getText())
            
            /// Donate the amount
            viewModal?.donateToCharity(cardDetails: cardModal)
        } else {
            self.alertView(INVALID_CARD_DETAILS, description: INVALID_CARD_DETAILS_DESCRIPTION)
        }
    }
    
    @IBAction func onTapDismiss(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

extension CharityDonationViewController: CharityDonationViewModalDelegate {
    
    func donationSuccessfull() {
        navigateSuccessfullTransactionScreen()
    }
    
    func donationError(_ title: String, description message: String) {
        activityIndicator?.stopAnimating()
        self.alertView(title, description: message)
    }
    
    func networkConnectionError() {
        activityIndicator?.stopAnimating()
        self.alertView(NETWORK_CONNECTION_FAIL_TITLE, description: NETWORK_CONNECTION_FAIL_DESCRIPTION)
    }
    
    func enterValidAmount() {
        activityIndicator?.stopAnimating()
        self.alertView(INVALID_AMOUNT, description: INVALID_AMOUNT_DESCRIPTION)
    }
    
    func insufficientBalanceFailed() {
        activityIndicator?.stopAnimating()
        self.alertView(INSUFFICIENT_BALANCE, description: INSUFFICIENT_BALANCE_DESCRIPTION)
    }
    
    private func navigateSuccessfullTransactionScreen() {
        activityIndicator?.stopAnimating()
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var successfullTransactionVC: SuccessfullTransactionViewController!
        if #available(iOS 13.0, *) {
            successfullTransactionVC = storyBoard.instantiateViewController(identifier: SuccessfullTransactionViewController.identifier)
        } else {
            successfullTransactionVC = storyBoard.instantiateViewController(withIdentifier: SuccessfullTransactionViewController.identifier) as? SuccessfullTransactionViewController
        }
        self.navigationController?.pushViewController(successfullTransactionVC, animated: true)
    }
    
}

