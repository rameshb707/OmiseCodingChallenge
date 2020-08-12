//
//  ODManager.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 11/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

class ODManager {
    
    /// Shared reference of the singleton object
    static let sharedInstance = ODManager()
    
    /// Base URL for which the API has to hit
    var baseURL: String = ""
    
    /// Private initializer so that no one can create another instance of ODManager
    private init() {
        initWithHost()
    }
    
    /**
        Fetches the host url from the info.plist file
     */
    func initWithHost() {
        var api: [String:String] = [:]
        if let apiInConfig = Bundle.main.object(forInfoDictionaryKey: "Api") as? [String:String] {
            api = apiInConfig
        }
        for (key,val) in api {
            if key == "host" {
                baseURL = val
            }
        }
    }
}
