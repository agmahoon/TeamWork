//
//  APIKey.swift
//  TeamWorkChallenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation

/** API class that expose key and it's secret */
class APIKey {
    private init() {
    }
    
    /**
     RESTful API secret key
     */
    static var apiKey: String {
        get {
            return "twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T"
        }
    }
    
    /**
     RESTful API secret password
     */
    static var apiPassword: String {
        get {
            return "x" // AS per teamwork api documentation.
        }
    }
}
