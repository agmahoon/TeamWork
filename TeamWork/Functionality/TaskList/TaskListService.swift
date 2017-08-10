//
//  TaskListService.swift
//  TeamWorkChallenge
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class TaskListService: Request {
    typealias success = (_ tasklist: Array<TaskList>) -> ()
    typealias failure = (_ error: NSError) -> ()
    
    fileprivate var successBlock : success
    fileprivate var failureBlock : failure
    fileprivate var _path : String?
    fileprivate var _method: HTTPMethod?
    fileprivate var _requestData: [String:String]?
    fileprivate var projectId: String
    
    var path: String {
        get {
            return self._path!
        }
    }
    
    var method: HTTPMethod {
        get {
            return self._method!
        }
    }
    
    var requestData: [String : String]? {
        get {
            return [:]
        }
    }
    
    init(projectId: String,
         successBlock: @escaping success,
         failureBlock: @escaping failure) {
        self.projectId = projectId
        self.successBlock = successBlock
        self.failureBlock = failureBlock
        self._path = "\(RESTfulAPIPaths.tasklistPath.replacingOccurrences(of: "{project_id}", with: self.projectId))"
        self._method = .get
    }
    
    func handleSuccessResponse(_ result: JSON?, response: HTTPURLResponse?) {
        guard let registerResponse = response, registerResponse.statusCode == 200 else {
            
            if response != nil  {
                self.handleError(self.failureError(statusCode: response?.statusCode), response: response)
            }
            return
        }
        
        if let tasklist = result?["tasklists"].rawString(), tasklist != "null" {
            if let allTasklist = Mapper<TaskList>().mapArray(JSONString: tasklist) {
                self.successBlock(allTasklist)
            }
        } else {
            self.handleError(nil, response: nil)
        }
    }
    
    func handleError(_ error: NSError?, response: HTTPURLResponse?){
        if let error = error {
            self.failureBlock(error)
        } else {
            self.failureBlock(self.failureError(statusCode: nil))
        }
    }
    
    private func failureError(statusCode: Int?) -> NSError {
        var code = 400
        if let statusCode = statusCode {
            code = statusCode
        }
        let userInfo: [AnyHashable: Any] = [
            NSLocalizedDescriptionKey :  NSLocalizedString("Error Occur", value: "Error Occur", comment: ""),
            NSLocalizedFailureReasonErrorKey : NSLocalizedString("Error Occur", value: "There is something wrong with request. Please try later.", comment: "This a generic message to save time. The better way is to handle all of the status code and adjust the error message according to the status code.")
        ]
        let error = NSError(domain: Constants.domain, code: code, userInfo: userInfo)
        return error
    }
}
