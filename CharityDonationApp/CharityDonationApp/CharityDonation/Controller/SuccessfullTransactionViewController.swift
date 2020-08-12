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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTapOk(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
