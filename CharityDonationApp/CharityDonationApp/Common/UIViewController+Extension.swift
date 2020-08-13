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
    
    /**
       Common UIActivityIndicatorView view to present on any viewcontroller

        - Parameters:
            - uiView: the view on which UIActivityIndicatorView has to show
    */
    func showActivityIndicatory(uiView: UIView) ->  UIActivityIndicatorView {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.center = uiView.center
        activityIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            
        }
        activityIndicator.color = UIColor(red: 29.0/255.0, green: 84.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        uiView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return activityIndicator
    }
}


