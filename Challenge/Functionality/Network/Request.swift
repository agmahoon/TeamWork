//
//  Request.swift
//  Challenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
import SwiftyJSON

enum HTTPMethod {
    case get, post, put
    static func stringHTTPMethods(_ method: HTTPMethod) -> String {
        switch method {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        }
    }
}

/**
 A protocol which is going to be implemented on web service calls.
 */
protocol Request: class {
    /**
     Path is extended location for the service along with base URL
     */
    var path: String {get}
    
    /**
     Method represent the http method based on which the request is sent.
     */
    var method: HTTPMethod {get}
    
    /**
     handleSuccesResponse will handle the success response for a request
     - param result: get JSON result when receiving a response from server.
     - param response: the complete http url response
     */
    func handleSuccessResponse(_ result: JSON?, response: HTTPURLResponse?)
    
    /**
     handleError will handle the error response for a request
     - param error: Represent the error when send a request to server.
     - param response: the complete http url response
     */
    func handleError(_ error: NSError?, response: HTTPURLResponse?)
    
    /**
     requestData is an input send to server for some operations.
     */
    var requestData: [String: String]? {get}
}

extension Request {
    var header: [String: String] {
        get {
            return [
                "Content-Type": "application/json"
            ]
        }
    }
}
