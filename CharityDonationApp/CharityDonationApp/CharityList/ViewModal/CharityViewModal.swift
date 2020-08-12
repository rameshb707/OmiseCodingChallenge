//
//  CharityViewModal.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

protocol CharityViewModalDelegate: AnyObject {
    /**
     Calls when it fetchs the Charity list successfully
     
      - Parameters:
        - list: List of charity model
     */
    func charityList(_ list: [Charity])
    
    /**
      Calls when internet connection is failed
    */
    func networkConnectionError()
    
    /**
     Calls on error occured during performing to fetch charity list
     
      - Parameters:
        - title: Error title
        - description: Error description
     */
    func charityListError(_ title: String, description message: String)
}

class CharityViewModal {
    
    /// Delegate
    weak var delegate: CharityViewModalDelegate?
    
    /// Global property use to make network call
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
        if let reachable = NetworkReachability.sharedInstance?.isReachable, reachable {
            let request = Request(endPoint: CHARITYLIST_END_POINT, parameters: nil, httpMethod: .GET)
            networkManager.send(modelType: CharityList.self, request) {[weak self] (charityList, error) in
                DispatchQueue.main.async {
                    if let charityListError = error {
                        self?.delegate?.charityListError(charityListError.title, description: charityListError.description)
                    }
                    if let list = charityList {
                        self?.delegate?.charityList((list as? CharityList)?.data ?? [])
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.delegate?.networkConnectionError()
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
        DispatchQueue.global(qos: .background).async {
            if let imageURL = URL(string: url) {
                self.networkManager.getData(from: imageURL) { data, response, error in
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
    
}
