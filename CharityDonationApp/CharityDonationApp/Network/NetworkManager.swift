//
//  NetworkManager.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

typealias resultCompletion = (T: Codable?, CharityDonationError?)

/// All the network managers should conform to this Protocol
protocol NetworkRequest: class {
    
    /**
    Schedules request operation

    - Parameters:
       - modelType: Operation object to be scheduled
       - Request: The network request that needs to be executed
       - completionHandler: A callback that is called on the completion of API call
    */
    func send<T: Codable>(modelType: T.Type,_ request: Request, _ completion: @escaping (resultCompletion) -> Void)
    
    /**
     Fetches the Image data from the URL

     - Parameters:
        - url: Logo URL
        - completion: A callback that is called on the completion of API call
     */
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())

}


/// This class maintains Schedule network request and fire tasks
class NetworkManager: NetworkRequest {
    
    // The shares seesion used to executr the task
    let session = URLSession.shared
    
   /**
    Schedules request operation

    - Parameters:
       - modelType: Operation object to be scheduled
       - Request: The network request that needs to be executed
       - completionHandler: A callback that is called on the completion of API call
    */
    func send<T: Codable>(modelType: T.Type,_ request: Request, _ completion: @escaping (resultCompletion) -> Void) {
        
        let dataRequest = URLRequest(request: request)
        
        let task = session.dataTask(with: dataRequest, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                let result = Validation.containsValidResponseInStatus(responseStaus: httpResponse)
                switch result {
                case .success:
                    guard let productData = data else { completion((nil, nil)); return; }
                    do {
                        let value = try JSONDecoder().decode(T.self, from: productData)
                        completion((value, nil))
                    } catch {
                        completion((nil, CharityDonationError.parseError("")))
                    }
                case .error(let error):
                    completion((nil, error))
                }
            }
            
        })
        task.resume()
    }
    
    /**
     Fetches the Image data from the URL

     - Parameters:
        - url: Logo URL
        - completion: A callback that is called on the completion of API call
     */
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}
