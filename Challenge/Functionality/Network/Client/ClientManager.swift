//
//  ClientManager.swift
//  Challenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
import Alamofire

/** Public interface for enqueue requests */
protocol ClientManager: class {
    
    /**
     enqueueRequest is used to queue an http request ( In theory it is just a name,
     almaofire has the queue setup already)
     - param request: A request that is being sent to server.
     */
    func enqueueRequest(_ request: Request)
}
