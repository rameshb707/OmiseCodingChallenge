//
//  CharityViewModal.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

protocol CharityViewModalDelegate: AnyObject {
    func charityList(list: [Charity])
}

class CharityViewModal {
    
    weak var delegate: CharityViewModalDelegate?
    
    private lazy var networkManager  = NetworkManager()
    
    init(delegate: CharityViewModalDelegate) {
        self.delegate = delegate
    }
    
    func getCharityList() {
        let request = Request(endPoint: "/charities", parameters: nil)
        networkManager.send(modelType: CharityList.self, request) { (charityList, response, error) in
             DispatchQueue.main.async {
                if let list = charityList {
                    self.delegate?.charityList(list: (list as? CharityList)?.data ?? [])
                }
             }
         }
    }
}
