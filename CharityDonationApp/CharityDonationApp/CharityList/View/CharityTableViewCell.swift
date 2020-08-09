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

}
