//
//  SendRequest.swift
//  Challenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 Handover the request to alamofire for server operation.
 */
class SendRequest: SendRequestManager {
    
    typealias completionBlock = (_ result: JSON?, _ response: HTTPURLResponse?) -> ()
    typealias failureBlock = (_ error: NSError?, _ response: HTTPURLResponse?) -> ()
    
    /**
     Send request
     - parameter request: The request object that has all the information that
     need to be send and also responsible for callback.
     - parameter success: Return the success response to caller i.e Client
     - parameter success: Return the failure response to caller i.e Client
     - return Alamofire.Request: Return the Request object of Alamofire.
     */
    func sendRequest(
        _ request: Request,
        success: @escaping (JSON?, HTTPURLResponse?) -> (),
        failure: @escaping (NSError?, HTTPURLResponse?) -> ()) {
        let urlString: String = RESTfulAPIPaths.baseURL + request.path
        
        let requestAlamofire = Alamofire.request(
            urlString,
            method: Alamofire.HTTPMethod(rawValue: HTTPMethod.stringHTTPMethods(request.method))!,
            parameters: request.requestData,
            encoding: URLEncoding.httpBody,
            headers: request.header
        )
        requestAlamofire
            .authenticate(user: APIKey.apiKey, password: APIKey.apiPassword)
            .responseJSON { (response) in
            if let networkResponse = response.response {
                var responseResult : JSON? = nil
                if let data = response.data {
                    responseResult = JSON(data: data)
                }
                success(responseResult, networkResponse)
            } else {
                failure(response.result.error as NSError?, response.response)
            }
        }
    }
}
