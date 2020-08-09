//
//  CharityViewModal.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation


protocol CharityViewModalDelegate: AnyObject {
    func charityList(_ list: [Charity])
}

class CharityViewModal {
    
    /// Delegate
    weak var delegate: CharityViewModalDelegate?
    
    /// Global property uses to make network call
    private lazy var networkManager  = NetworkManager()
    
    /// Custom Initializer to confirm the delegate who is using the viewmodal to get neccessary infromation
    init(delegate: CharityViewModalDelegate) {
        self.delegate = delegate
    }
    
    /**
     Fetches the charity list form the endpoint by calling api from Network Manager.
     On Success it delgaates back to view to populate
    */
    func getCharityList() {
        let request = Request(endPoint: "/charities", parameters: nil, httpMethod: .GET)
        networkManager.send(modelType: CharityList.self, request) { (charityList, response, error) in
            DispatchQueue.main.async {
                if let list = charityList {
                    self.delegate?.charityList((list as? CharityList)?.data ?? [])
                }
            }
        }
    }
    
   /**
    Fetches the Image data from the URL

    - Parameters:
       - url: Logo URL
       - completion: A callback that is called on the completion of API call
    */
    func getImage(from url: String,_ completion: @escaping (Data) -> Void){
        if let imageURL = URL(string: url) {
            networkManager.getData(from: imageURL) { data, response, error in
                guard let image = data, error == nil else {
                    return
                }
                DispatchQueue.main.async() {
                    completion(image)
                }
            }
        }
    }
    
}
