//
//  SendRequestManager.swift
//  TeamWorkChallenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias success = (_ result: JSON?, _ response: HTTPURLResponse?) -> ()
typealias failure = (_ error: NSError?, _ response: HTTPURLResponse?) -> ()

/**
 Interface for sending request to server
 */
protocol SendRequestManager: class {
    
    /**
     Send request to backen for prcessing
     - parameter request: Contains the information that is going to send to server
     - parameter success: The closure for success results
     - parameter failure: The closure for failure results.
     - return Alamofire.Request: Return the Request object of Alamofire.
     */
    func sendRequest(_ request: Request, success: @escaping success, failure: @escaping failure)
}
