//
//  SuccessfullTransactionViewController.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 11/8/2563 BE.
//  Copyright © 2563 Ramesh B. All rights reserved.
//

import UIKit

class SuccessfullTransactionViewController: UIViewController {

    /// Storyboard identifier to fetch the viewcontroller
    static let identifier: String = String(describing: SuccessfullTransactionViewController.self)
    
    // MARK: Properties
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.layer.cornerRadius = 8
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    @IBAction func onTapOk(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
