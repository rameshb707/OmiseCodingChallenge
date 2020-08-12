//
//  Reguest.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 08/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//

import Foundation

protocol EndPoint {
    var parameters: APIParams? { get set} // Request Body/ Query Params
    var httpMethod: RequestType { get set }
    var endPoint: String { get set }
    func getFullURL() -> String
}

/// Request object contains supporting properties in order to construct the request
struct Request: EndPoint {
    
    /// API Request endpoint
    var endPoint: String
    
    /// Parameter of the request body in dictionory format
    var parameters: APIParams?
    
    /// Http request method type
    var httpMethod: RequestType
    
    /// Base URL from which the server will be triggered
    private var baseURL: String {
        return ODManager.sharedInstance.baseURL
    }
    
    /// Final URL to which the request has to be hit with necessary request body
    func getFullURL() -> String {
        if let prameter = self.parameters {
            return self.baseURL + endPoint + prameter.asString
        }
        return self.baseURL + endPoint
    }
}

