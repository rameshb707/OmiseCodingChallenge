//
//  ViewController.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import UIKit

class CharityListViewController: UIViewController {


    // MARK:- Outlets
    @IBOutlet weak var charityListTableView: UITableView!
    
    // MARK:- Properties
    var charityList: [Charity]? {
        didSet {
            charityListTableView.reloadData()
        }
    }
    
    /// ViewModal property
    var viewModal: CharityViewModal?
    
    // MARK:- Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Registering the custom tableview cell
        registerTableViewCell()
        
        /// ViewModal Object with CharityListViewController confirming through initializer
        viewModal = CharityViewModal(delegate: self)
        
        /// Getting the charity list to load in tableview
        viewModal?.getCharityList()
    }
    
}

extension CharityListViewController {
    private func registerTableViewCell() {
        self.charityListTableView?.register(UINib(nibName: CharityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CharityTableViewCell.identifier)
    }
}

extension CharityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charityList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharityTableViewCell.identifier, for: indexPath) as? CharityTableViewCell
        viewModal?.getImage(from: (charityList?[indexPath.row].logoUrl ?? ""), { (imageData) in
                cell?.imageView?.image = UIImage(data: imageData)
                cell?.layoutSubviews()
        })
        cell?.charityNameLabel.text = charityList?[indexPath.row].name
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharityCell_Height_Constant
    }
}


extension CharityListViewController: CharityViewModalDelegate {
    
    /// Delgate function returns the charity list to load
    func charityList(_ list: [Charity]) {
        self.charityList = list
    }
}
