//
//  CharityTableViewCell.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 09/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import UIKit

class CharityTableViewCell: UITableViewCell {

    static let identifier = String(describing: CharityTableViewCell.self)
    
    @IBOutlet weak var charitylogoImageView: UIImageView!
    @IBOutlet weak var charityNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        self.contentView.backgroundColor = .white
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.shadowRadius = 5
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowOpacity = 0.3
    }

}
