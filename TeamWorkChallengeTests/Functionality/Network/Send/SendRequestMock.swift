//
//  SendRequestMock.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
import SwiftyJSON
@testable import TeamWorkChallenge

/**
 Mocking request send to backend
 */
class SendRequestMock: SendRequestManager {
    
    enum ResultType {
        case success
        case failure
        case unknown
    }
    
    enum RequestType {
        case project
        case tasklist
        case task
        case none
    }
    
    fileprivate var filename = "projects"
    
    /** Determine the mocking result type */
    var resultType : ResultType = .unknown
    
    /** Determine the mocking result type */
    var requestType : RequestType = .project {
        didSet {
            switch self.requestType {
            case .project:
                self.filename = "projects"
            case .tasklist:
                self.filename = "tasklist"
            case .task:
                self.filename = "tasks"
            case .none:
                self.filename = ""
            }
            
        }
    }
    
    typealias completionBlock = (_ result: JSON?, _ response: HTTPURLResponse?) -> ()
    typealias failureBlock = (_ error: NSError?, _ response: HTTPURLResponse?) -> ()
    
    /**
     SendRequest
     - parameter request: Contains the information that is going to send to server
     - parameter success: The closure for success results
     - parameter failure: The closure for failure results.
     */
    func sendRequest(
        _ request: Request,
        success: @escaping (JSON?, HTTPURLResponse?) -> (),
        failure: @escaping (NSError?, HTTPURLResponse?) -> ()) {
        
        switch self.resultType {
        case .success:
            
            let url = NSURL(string: RESTfulAPIPaths.baseURL + request.path)
            let statusCode = 200
            
            let parser = JSONParserHelper()
            let projectResponse = parser.parseJSON(self.filename)
            let response = HTTPURLResponse(url: url! as URL, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: request.header)
            
            success(projectResponse, response)
        case .failure:
            
            let url = NSURL(string: RESTfulAPIPaths.baseURL + request.path)
            let statusCode = 404
            let response = HTTPURLResponse(url: url! as URL, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: request.header)
            
            let userInfo: [NSObject : AnyObject] = [
                NSLocalizedFailureReasonErrorKey as NSObject : NSLocalizedString("Error", value: "Unable to process your request", comment: "") as AnyObject
            ]
            let error = NSError(domain: Constants.domain, code: 1000, userInfo: userInfo)
            failure(error, response)
            
        case .unknown:
            let url = NSURL(string: RESTfulAPIPaths.baseURL + request.path)
            let statusCode = 500
            let response = HTTPURLResponse(url: url! as URL, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: request.header)
            
            let userInfo: [NSObject : AnyObject] = [
                NSLocalizedFailureReasonErrorKey as NSObject : NSLocalizedString("Error", value: "Unreachable server.", comment: "") as AnyObject
            ]
            let error = NSError(domain: Constants.domain, code: 1000, userInfo: userInfo)
            failure(error, response)
        }
    }
}
