//
//  UIViewController+Extension.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 11/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
       Common Alert view to present on any viewcontroller

        - Parameters:
            - title: Alert title string
            - description:the: Alert description
    */
    func alertView(_ title: String, description message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
