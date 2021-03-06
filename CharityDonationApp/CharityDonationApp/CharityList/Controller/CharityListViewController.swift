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
            if !charityList.isEmpty {
                charityListTableView?.reloadData()
            } else {
                self.alertView(EMPTY_CHARITY_LIST, description: EMPTY_CHARITY_LIST_ESCRIPTION)
            }
        }
    }
    
    var activityIndicator: UIActivityIndicatorView?
    
    /// ViewModal property
    var viewModal: CharityViewModal!
    
    // MARK:- Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Basic Setup
        setUpView()
        
        /// ViewModal Object with CharityListViewController confirming through initializer
        viewModal = CharityViewModal(delegate: self)
        
        /// Getting the charity list to load in tableview
        viewModal.getCharityList()
        
        /// Adds activity indicator while fetching charity list
        activityIndicator = self.showActivityIndicatory(uiView: self.view)
    }
    

    
}

extension CharityListViewController {
    private func registerTableViewCell() {
        self.charityListTableView?.register(UINib(nibName: CharityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CharityTableViewCell.identifier)
    }
    
    private func setUpView() {
        
        /// Registering the custom tableview cell
        registerTableViewCell()
        
        /// Adding UIRefreshControl to the tableview
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)

        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        charityListTableView.refreshControl = refreshControl
    }
    
    @objc func refreshTableView(refreshControl: UIRefreshControl) {
        /// Getting the charity list to load in tableview
        viewModal.getCharityList()
        activityIndicator?.startAnimating()
        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
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
        return 350
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
        activityIndicator?.stopAnimating()
    }
    
    func networkConnectionError() {
        activityIndicator?.stopAnimating()
        self.alertView(NETWORK_CONNECTION_FAIL_TITLE, description: NETWORK_CONNECTION_FAIL_DESCRIPTION)
    }
    
    func charityListError(_ title: String, description message: String) {
         activityIndicator?.stopAnimating()
         self.alertView(title, description: message)
    }
}
