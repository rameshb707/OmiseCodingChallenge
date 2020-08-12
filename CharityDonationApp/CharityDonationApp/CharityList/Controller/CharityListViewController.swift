//
//  ViewController.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import UIKit

class CharityListViewController: UIViewController {

    /// Storyboard identifier to fetch the viewcontroller
    static let identifier: String = String(describing: CharityListViewController.self)
    
    // MARK:- Outlets
    @IBOutlet weak var charityListTableView: UITableView!
    
    // MARK:- Properties
    var charityList: [Charity] = [] {
        didSet {
            charityListTableView?.reloadData()
        }
    }
    
    /// ViewModal property
    var viewModal: CharityViewModal!
    
    // MARK:- Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Registering the custom tableview cell
        registerTableViewCell()
        
        /// ViewModal Object with CharityListViewController confirming through initializer
        viewModal = CharityViewModal(delegate: self)
        
        /// Getting the charity list to load in tableview
        viewModal.getCharityList()
    }
    
}

extension CharityListViewController {
    private func registerTableViewCell() {
        self.charityListTableView?.register(UINib(nibName: CharityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CharityTableViewCell.identifier)
    }
}

// MARK: Table View DataSource
extension CharityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharityTableViewCell.identifier, for: indexPath) as! CharityTableViewCell
        viewModal.getImage(from: (charityList[indexPath.row].logoUrl), { (imageData) in
                cell.charitylogoImageView?.image = UIImage(data: imageData)
                cell.layoutSubviews()
        })
        cell.charityNameLabel.text = charityList[indexPath.row].name
        return cell
    }
}

// MARK: Table View Delegate
extension CharityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharityCell_Height_Constant
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToCharityDonationScreen()
    }
    
    /// Navigate to CharityDonationViewController on selecting the charity
    private func navigateToCharityDonationScreen() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var charityDonationVC : CharityDonationViewController!
        if #available(iOS 13.0, *) {
            charityDonationVC = storyBoard.instantiateViewController(identifier: CharityDonationViewController.identifier)
        } else {
            charityDonationVC = storyBoard.instantiateViewController(withIdentifier: CharityDonationViewController.identifier) as? CharityDonationViewController
        }
        let navController = UINavigationController(rootViewController: charityDonationVC)
        /// Calling in main queue since the cell selection type is none 
        DispatchQueue.main.async {
            self.present(navController, animated: true, completion: nil)
        }
    }
}

// MARK: CharityViewModalDelegate
extension CharityListViewController: CharityViewModalDelegate {
    
    func charityList(_ list: [Charity]) {
        self.charityList = list
    }
    
    func networkConnectionError() {
        self.alertView(NETWORK_CONNECTION_FAIL_TITLE, description: NETWORK_CONNECTION_FAIL_DESCRIPTION)
    }
    
    func charityListError(_ title: String, description message: String) {
         self.alertView(title, description: message)
    }
}
