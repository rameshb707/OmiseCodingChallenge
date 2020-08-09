//
//  URLRequestExtension.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

extension URLRequest {
    
    /// Custom Initializer used to create the URLRequest using the rwquest object
    init(request: Request) {
        self.init(url: URL.init(string: request.getFullURL())!)
        httpMethod = request.httpMethod.method
    }
}
